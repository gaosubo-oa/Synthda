<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-06-03
  Time: 9:54
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
<!DOCTYPE html >
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>关键任务填报</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
		<link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
		<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
		<script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../js/jquery/jquery.cookie.js"></script>
		<script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
		<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
		<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>

		<style>
			html, body {
				width: 100%;
				height: 100%;
				background: #fff;
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

			.item {
				font-size: 22px;
				margin-left: 10px;
				color: #494d59;
				margin-top: 2px
			}


			.query .layui-form-label {
				width: 60px;
			}

			.query .layui-input-block {
				margin-left: 90px;
			}

			.query .layui-input-block {
				margin-left: 90px;
			}

			.query .layui-input-block input {
				height: 35px;
			}

			.sty {
				margin: 2px 0px 0px 32px;
			}

			.icon {
				background: #009688;
				display: inline-block;
				width: 40px;
				height: 30px;
				margin-top: 2px;
				margin-left: 20px;
				font-size: 25px;
				text-align: center;
				color: #fff;
				border-radius: 2px;
			}

			.share {
				width: calc(97.5% / 2);
				height: 100%;
				float: left;
			}

			.right p span {
				color: #666;
				font-size: 16px;
			}

			.right p {
				line-height: 34px;
			}

			.right p i {
				font-style: normal;
			}

			.right .font span {
				margin-right: 30px;
			}

			.right .font .red {
				color: red;
			}

			.right p span {
				color: #666;
				font-size: 16px;
			}

			.right p {
				line-height: 34px;
			}


			.taskright {
				border: 1px solid #ccc;
			}

			.taskright p span {
				color: #666;
				font-size: 16px;
			}

			.taskright p {
				line-height: 34px;
			}

			.taskright {
				margin-top: 10px;
			}

			.taskright p i {
				font-style: normal;
			}

			.taskright .font span {
				margin-right: 30px;
			}

			.taskright .font .red {
				color: red;
			}

			.taskright {
				border: 1px solid #ccc;
				margin-left: 5px;
			}

			.taskright p span {
				color: #666;
				font-size: 16px;
			}

			.taskright p {
				line-height: 34px;
			}

			.btn {
				background: #d9d9d9;
				color: #000;
			}

			.layui-layer-btn {
				text-align: center;
			}

			/*.progress div{*/
			/*margin-bottom: 20px;*/
			/*}*/
			.progress {
				font-size: 16px;
			}

			.openFile input[type=file] {
				position: absolute;
				top: 0;
				right: 0;
				bottom: 0;
				left: 0;
				width: 100%;
				height: 18px;
				z-index: 99;
				opacity: 0;
			}

			td {
				cursor: pointer
			}

			.layui_tr_active {
				background-color: #009688 !important;
                color: #fff !important;
			}

			.operationDiv {
				display: none;
				position: absolute;
				top: -50px;
				left: 5px;
				background: #fff;
				box-shadow: 0 0 5px 0 rgb(0, 0, 0);
				border-radius: 5px;
			}
			.divShow {
				position: relative;
			}
			.divShow:hover .operationDiv {
				display: block;
			}
			.icon_item {
				float: left;
				line-height: 25px;
				padding: 0 5px;
			}
			.icon_img {
				width: 20px;
				height: 20px;
			}
			.td_img {
				width: 20px;
			}
			.bar {
				height: 18px;
				background: green;
			}
			#rightName {
				color: blue;
				cursor: pointer;
			}
		</style>

		<script type="text/javascript">
            var funcUrl = location.pathname;
            var authorityObject = null;
            if (funcUrl) {
                $.ajax({
                    type: 'GET',
                    url: '/plcPriv/findPermissions',
                    data: {
                        funcUrl: funcUrl
                    },
                    dataType: 'json',
                    async: false,
                    success: function (res) {
                        if (res.flag) {
                            if (res.object && res.object.length > 0) {
                                authorityObject = {}
                                res.object.forEach(function (item) {
                                    authorityObject[item] = item;
                                });
                            }
                        }
                    },
                    error: function () {

                    }
                });
            }
		</script>

	</head>
	<body>
		<input type="hidden" id="allId">
		<%--<div class="headImg" style="padding-top: 10px">
		<span class="item">
			<img style="margin-left:1.5%" src="/img/commonTheme/theme6/icon_summary.png" alt="">
			<span class="headTitle"style="margin-left: 10px">计划执行填报</span>
		</span>
		</div>
		<hr style="margin-bottom: 0;">--%>
		<div class="layui-tab layui-tab-brief clearfix" lay-filter="TabBrief" style="margin-top: 0;padding: 0 15px;">
			<ul class="layui-tab-title targetOrItem" style="float: left">
				<li class="layui-this">正进行</li>
				<li class="task">已完成</li>
			</ul>
			<ul class="icon_box clearfix" style="float: left;margin-left: 5%;margin-top: 10px">
				<li class="icon_item">
					状态图标：
				</li>
				<li class="icon_item">
					<img class="icon_img" src="/img/planCheck/planProgressReport/not_started.png">
					<span class="icon_tip">未开始</span>
				</li>
				<li class="icon_item">
					<img class="icon_img" src="/img/planCheck/planProgressReport/underway.png">
					<span class="icon_tip">进行中</span>
				</li>
				<li class="icon_item">
					<img class="icon_img" src="/img/planCheck/planProgressReport/delay_underway.png">
					<span class="icon_tip">将到期</span>
				</li>
				<li class="icon_item">
					<img class="icon_img" src="/img/planCheck/planProgressReport/out_underway.png">
					<span class="icon_tip">已延期</span>
				</li>
				<li class="icon_item">
					<img class="icon_img" src="/img/planCheck/planProgressReport/complete.png">
					<span class="icon_tip">完成</span>
				</li>
				<li class="icon_item">
					<img class="icon_img" src="/img/planCheck/planProgressReport/delay_complete.png">
					<span class="icon_tip">延期完成</span>
				</li>
				<li class="icon_item">
					<img class="icon_img" src="/img/planCheck/planProgressReport/result_default.png">
					<span class="icon_tip">成果不符</span>
				</li>
				<li class="icon_item">
					<img class="icon_img" src="/img/planCheck/planProgressReport/closed.png">
					<span class="icon_tip">关闭</span>
				</li>
				<li class="icon_item">
					<img class="icon_img" src="/img/planCheck/planProgressReport/suspend.png">
					<span class="icon_tip">暂停</span>
				</li>
			</ul>
			<div class="layui-tab-content" style="position: absolute;top: 35px;right: 0;bottom: 80px;left: 0;">
				<div class="layui-tab-item layui-show">
					<form class="layui-form" action="" style="margin-top: 10px;">
						<%--筛选查询--%>
						<div class="query layui-row" >
							<div class="layui-col-xs2">
								<div class="layui-form-item">
									<label class="layui-form-label">项目名称</label>
									<div class="layui-input-block">
										<input type="text" name="tgName" required lay-verify="required" autocomplete="off" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-xs2">
								<div class="layui-form-item">
									<label class="layui-form-label">所属单位</label>
									<div class="layui-input-block">
										<select name="modules" lay-verify="required" class="deptName">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
							</div>
							<div class="layui-col-xs2">
								<div class="layui-form-item">
									<label class="layui-form-label">计划类型</label>
									<div class="layui-input-block">
										<select name="planType" lay-verify="required" class="planType">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
							</div>
							<div class="layui-col-xs2">
								<div class="layui-form-item">
									<label class="layui-form-label">年度</label>
									<div class="layui-input-block">
										<%--                                        <input type="text" name="year" lay-verify="required" id="date"  autocomplete="off" class="layui-input">--%>
										<select name="year" lay-filter="year">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
							</div>
							<div class="layui-col-xs2">
								<div class="layui-form-item">
									<label class="layui-form-label">月度</label>
									<div class="layui-input-block">
										<select name="month">
											<option value="">请选择</option>
										</select>
										<%--                                        <input type="text" name="month" id="datemonth" lay-verify="required" autocomplete="off" class="layui-input">--%>
									</div>
								</div>
							</div>
							<div class="layui-col-xs2">
								<div class="authority_search" style="display: none;">
									<button type="button" class="layui-btn layui-btn-sm sty search">查询</button>
									<button type="button" class="layui-btn layui-btn-sm sty clear" style="margin-left: 20px;">重置</button>
									<i class="layui-icon layui-icon-spread-left icon" style="display:none;"></i>
								</div>
							</div>
						</div>
					</form>
					<div class="layui-tab-content" style="width:100%;padding:0px;">
						<div class="clearfix">
							<div class="share" style="width: 50%;float: left;">
								<div>
									<table class="layui-hide" id="test" lay-filter="test"></table>
								</div>
							</div>
							<div class="share" id="rightShow" style="margin-left: 5px;width: 48%;float: right;">
								<div class="right" style="height: 100%">

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			//查看项目信息使用
			var tgId_infor=''
			//每日填报情况
			var dayReport
			// 成果材料附件
			var successFileStr = '';
			// 异常原因附件
			var failFIleStr = '';
			//最终成果材料
			var finalSuccessFileStr=''
			//最终异常材料
			var finalFailFIleStr=''
            initAuthority();

            var dictionaryObj = {
                UNIT: {},
				PLAN_SYCLE: {},
				RENWUJIHUA_TYPE: {},
				CONTROL_LEVEL:{},
				TG_TYPE:{},
				PLAN_PHASE:{},
				CGCL_TYPE:{},
            }
            var dictionaryStr = 'UNIT,PLAN_SYCLE,RENWUJIHUA_TYPE,CONTROL_LEVEL,TG_TYPE,PLAN_PHASE,CGCL_TYPE';
            // 获取数据字典数据
            $.get('/Dictonary/selectDictionaryByDictNos', {dictNos: dictionaryStr}, function (res) {
                if (res.flag) {
                    for (var dict in dictionaryObj) {
                        dictionaryObj[dict] = {object: {}, str: ''}
                        if (res.object[dict]) {
                            res.object[dict].forEach(function (item) {
                                dictionaryObj[dict]['object'][item.dictNo] = item.dictName;
                                dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>';
                            });
                        }
                    }
                }
                // init();
            });

            $('#rightShow').height($(window).height() - 120);
            window.onresize = function(){
                $('#rightShow').height($(window).height() - 120);
            }
            layui.use(['table', 'layer', 'form', 'element', 'laydate', 'upload'], function () {
                var table = layui.table,
                    form = layui.form,
                    layer = layui.layer,
                    laydate = layui.laydate,
                    element = layui.element,
                    upload = layui.upload;
                var tableInit
                /********************所属单位的ajax***************/
                $.ajax({
                    url: '/department/getDeptTop',
                    dataType: 'json',
                    type: 'get',
                    success: function (res) {
                        var obj = res.obj
                        var str = ''
                        for (var i = 0; i < obj.length; i++) {
                            str += '<option value="' + obj[i].deptId + '">' + obj[i].deptName + '</option>'
                        }
                        $('[name="modules"]').append(str)
                        form.render('select');
                    }
                })
                // 计划类型的ajax
                $.ajax({
                    url: '/Dictonary/selectDictionaryByNo?dictNo=PLAN_TYPE',
                    dataType: 'json',
                    type: 'get',
                    success: function (res) {
                        var obj = res.data
                        var str = ''
                        for (var i = 0; i < obj.length; i++) {
                            str += '<option value="' + obj[i].dictId + '">' + obj[i].dictName + '</option>'
                        }
                        $('[name="planType"]').append(str)
                        form.render('select');
                    }
                })
                // 获取计划期间年度列表
                $.get('/planPeroidSetting/selectAllYear', function (res) {
                    // 计划期间年度列表
                    var allYear = '';
                    if (res.object.length > 0) {
                        res.object.forEach(function (item) {
                            allYear += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>'
                        });
                    }
                    $('.query [name="year"]').append(allYear);
                    form.render('select');
                });
                // 获取月度
                form.on('select(year)', function (data) {
                    if (data.value) {
                        getPlanMonth(data.value, function (monthStr) {
                            $('.query [name="month"]').html(monthStr);
                            form.render('select');
                        });
                    } else {
                        $('.query [name="month"]').html('<option value="">请选择</option>');
                        form.render('select');
                    }
                });
                form.render();
                element.on('tab(TabBrief)', function (data) {
                    // console.log(data.index); //得到当前Tab的所在下标
                    if (data.index == 0) {
                        tableShow(1)
                    } else {
                        tableShow(2)
                    }
                });

                //表格
                function tableShow(complete) {
					var cols = [[
						// {title: '序号', type: 'numbers', minWidth: 60}
						{
							field: 'taskStatus', title: '状态', width: 60, align: 'center', templet: function (d) {
								if (d.taskStatus == '0') {
									// '未开始';
									return '<img class="td_img" src="/img/planCheck/planProgressReport/not_started.png"/>';
								} else if (d.taskStatus == '1') {
									// '进行中';
									return '<img class="td_img" src="/img/planCheck/planProgressReport/underway.png"/>';
								} else if (d.taskStatus == '2') {
									// '将到期';
									return '<img class="td_img" src="/img/planCheck/planProgressReport/delay_underway.png"/>';
								} else if (d.taskStatus == '4') {
									// '已延期';
									return '<img class="td_img" src="/img/planCheck/planProgressReport/out_underway.png"/>';
								} else if (d.taskStatus == '7') {
									// '暂停';
									return '<img class="td_img" src="/img/planCheck/planProgressReport/suspend.png"/>';
								} else if (d.taskStatus == '5') {
									// '完成';
									return '<img class="td_img" src="/img/planCheck/planProgressReport/complete.png"/>';
								} else if (d.taskStatus == '6') {
									// '延期完成';
									return '<img class="td_img" src="/img/planCheck/planProgressReport/delay_complete.png"/>';
								}
								else if (d.taskStatus == '9') {
									// '成果不符';
									return '<img class="td_img" src="/img/planCheck/planProgressReport/result_default.png"/>';
								}
								else if (d.taskStatus == '8') {
									// '关闭';
									return '<img class="td_img" src="/img/planCheck/planProgressReport/closed.png"/>';
								} else {
									return '';
								}
							}
						}
						, {field: 'tgName', title: '关键任务名称', minWidth: 300,templet:function (d) {
								if(d.assistanceStatus==1){
									return '(协助计划)'+d.tgName
								}else{
									return d.tgName
								}
							}}
						, {field: 'planEndDate', title: '计划完成时间', minWidth: 150}
						, {field: 'deptName', title: '部门名称', minWidth: 150}
					]]
                    tableInit = table.render({
                        elem: '#test'
                        , url: '/projectTarget/queryAndDept'
                        , parseData: function (res) { //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "data": res.obj,//解析数据列表
                                "count": res.totleNum //解析数据长度
                            };
                        },
                        where: {
							complete: complete,
							allocationStatus:1,
							_:new Date().getTime(),
							useFlag:true
                        }
                        , cols: cols
                        , page: true
						,limit: 50
	                    , height: 'full-130'
                        , done: function (res) {
                            var $trEles = this.elem.parent().find('.layui-table-body').find('tr');
                            if ($trEles.length > 0) {
                                $trEles.eq(0).addClass('layui_tr_active');
                            }
                            if (res.data == '' || res.data == undefined) {
                                var str = '<div style="height:486px;line-height: 486px;color:#666;text-align: center;font-size: 30px">暂无数据</div>'
								$('.right').html(str)
                            } else {
                                var tgId= res.data[0].tgId
								$('#allId').val(tgId)
                                var planEndDate = res.data[0].planEndDate
                                var resultDict = res.data[0].resultDictList
                                var openNextTask = res.data[0].openNextTask
                                var resultStandard = res.data[0].resultStandard
                                var itemApprivalStatus = res.data[0].itemApprivalStatus
                                if (itemApprivalStatus) {
                                    $('#allId').attr('itemApprivalStatus', itemApprivalStatus)
                                } else {
                                    $('#allId').attr('itemApprivalStatus', '')
                                }
                                var tName = res.data[0].tgName
	                            var deptId = res.data[0].deptId
								var deptType = res.data[0].deptType
								if (deptType) {
									$('#allId').attr('deptType', deptType)
								} else {
									$('#allId').attr('deptType', '')
								}
								var assistanceStatus = res.data[0].assistanceStatus
								if (assistanceStatus) {
									$('#allId').attr('assistanceStatus', assistanceStatus)
								} else {
									$('#allId').attr('assistanceStatus', '')
								}
								var taskStatus = res.data[0].taskStatus
								if (taskStatus) {
									$('#allId').attr('taskStatus', taskStatus)
								} else {
									$('#allId').attr('taskStatus', '')
								}

								//判断主项关键任务是中心、区域或总承包部
								if(deptType==2){ //区域
									var resultFileList = res.data[0].attachments5 || '';
									var errorFileList = res.data[0].attachments7 || '';
								}else if(deptType==3){ //总承包部
									var resultFileList = res.data[0].attachments6 || '';
									var errorFileList = res.data[0].attachments8 || '';
								}else{
									var resultFileList = res.data[0].attachments2 || '';
									var errorFileList = res.data[0].attachments3 || '';
								}
                                rightnum(tgId,planEndDate, resultStandard, resultDict, openNextTask, itemApprivalStatus,tName,resultFileList,errorFileList,deptId);

                            }
                        }
                    });
                }

                tableShow(1)
                //点击行
                table.on('row(test)', function (obj) {
                    $(this).siblings().removeClass('layui_tr_active');
                    $(this).addClass('layui_tr_active');
                    var data = obj.data;
                    var tgId = data.tgId
					$('#allId').val(tgId)
                    var aa = data.planEndDate
                    var result = data.resultStandard
                    var resultDict = data.resultDictList
                    var openNextTask = data.openNextTask
                    var itemApprivalStatus = data.itemApprivalStatus
                    if (itemApprivalStatus) {
                        $('#allId').attr('itemApprivalStatus', itemApprivalStatus)
                    } else {
                        $('#allId').attr('itemApprivalStatus', '')
                    }
                    var tName = obj.data.tgName
                    var deptId = data.deptId
					var deptType = data.deptType
					if (deptType) {
						$('#allId').attr('deptType', deptType)
					} else {
						$('#allId').attr('deptType', '')
					}
					var assistanceStatus = data.assistanceStatus
					if (assistanceStatus) {
						$('#allId').attr('assistanceStatus', assistanceStatus)
					} else {
						$('#allId').attr('assistanceStatus', '')
					}
					var taskStatus =data.taskStatus
					if (taskStatus) {
						$('#allId').attr('taskStatus', taskStatus)
					} else {
						$('#allId').attr('taskStatus', '')
					}

					//判断主项关键任务是中心、区域或总承包部
					if(deptType==2){ //区域
						var resultFileList = data.attachments5 || '';
						var errorFileList = data.attachments7 || '';
					}else if(deptType==3){ //总承包部
						var resultFileList = data.attachments6 || '';
						var errorFileList = data.attachments8 || '';
					}else{
						var resultFileList = data.attachments2 || '';
						var errorFileList = data.attachments3 || '';
					}
                    rightnum(tgId,aa, result, resultDict, openNextTask, itemApprivalStatus, tName,resultFileList,errorFileList,deptId)

                });

                //右侧数据
                function rightnum(tgId,aa, result, resultDict, openNextTask, itemApprivalStatus,tName,resultFileList,errorFileList,deptId) {
					successFileStr=''
					failFIleStr=''
					finalSuccessFileStr=''
					finalFailFIleStr=''
					tgId_infor=tgId
					var datas = {tgId: tgId,deptId:deptId}
					$('#allId').attr('deptId', deptId)
                    $.ajax({
                        url: '/ProjectDaily/selectProjectDailyByItemId',
                        dataType: 'json',
                        type: 'get',
                        data: datas,
                        success: function (res) {
                            var data = res.data
                            var strs = ''
                            strs = '<form class="layui-form content" action="" style="height:100%"><div id="rightHead">\n' +
                                '                <%--右侧的按钮--%>\n' +
                                '                <div>\n' +
                                '                    <button type="button" class="layui-btn layui-btn-sm today" style="display: none;">进展填报</button>\n' +
                                '                    <button type="button" class="layui-btn layui-btn-sm Collaborator" style="display: none;">增加协作人</button>\n' +
                                '                    <button type="button" class="layui-btn layui-btn-sm transfer" style="display: none;">转办</button>\n' +
                                '                    <button type="button" class="layui-btn layui-btn-sm" id="submit" style="display: none;">提交审核</button>\n' +
                                '                </div>\n' +
                                '                <p><span style="margin-right: 15px">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称:</span><span id="rightName" deptId="'+deptId+'" tgId="'+tgId+'">' + tName +'</span></p>\n' +
                                '                <p><span style="margin-right: 15px">累计完成百分比:</span><span class="completeQuantity">' + function () {
                                    if (data.length != 0) {
                                        var bigValue = data[0].completeQuantity
                                        for (var i = 0; i < data.length; i++) {
                                            if (data[i].completeQuantity > bigValue) {
                                                bigValue = data[i].completeQuantity
                                            }
                                        }
                                        return bigValue
                                    } else {
                                        return 0
                                    }
                                }() + '</span>' + '%' + '<span style="margin-left:50px;margin-right: 15px">计划结束日期:</span><span>' + empty(aa) + '</span></p>\n' +
                                '                <p class="font"><span style="margin-right: 15px">紧急程度:</span>'+function () {
											if(data.length != 0){
												if(data[0].urgent==1){
													return '<span class="red"><i>●</i>重要紧急</span>'
												}else if(data[0].urgent==2){
													return '<span><i style="color: #fac090">●</i>重要不紧急</span>'

												}else if(data[0].urgent==3){
													return '<span><i style="color: #92d050;">●</i>不重要紧急</span>'

												}else if(data[0].urgent==4){
													return '<span><i style="color:#558ed5">●</i>不重要不紧急</span>'
												}else {
													return ''
												}
											}else{
												return  ''
											}
									}()+'</p>\n' +
                                '                <p><span style="margin-right: 15px">完成标准:</span><span>' + empty(result) + '</span></p>\n' +
                               function () {
                                    var resultFileStr = '';
                                    if (!!resultFileList && resultFileList.length > 0) {
                                        var str = '';
                                        resultFileList.forEach(function (item) {
                                            var attachName = item.attachName;
                                            var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                            var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                            var attachmentUrl = item.attUrl;
                                            attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                            fileExtension = fileExtension.toLowerCase();

                                            str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                '<div class="operationDiv">' + function () {
                                                    if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                    } else {
                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                    }
                                                }() +
                                                '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                + '</div>' +
                                                '</div>'
                                        });
                                        resultFileStr = '<div class="clearfix"><span style="float: left;font-size: 16px; color: #666;">最终成果:</span><div style="float:left;width: calc(100% - (151px));">' + str + '</div></div>';
                                    }
                                    return resultFileStr;
                                }() +
	                                function(){
                                        var errorFileStr = '';
                                    if (!!errorFileList && errorFileList.length > 0) {
                                        var str = '';

                                        errorFileList.forEach(function (item) {
                                            var attachName = item.attachName;
                                            var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                            var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                            var attachmentUrl = item.attUrl;
                                            attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                            fileExtension = fileExtension.toLowerCase();

                                            str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                '<div class="operationDiv">' + function () {
                                                    if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                    } else {
                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                    }
                                                }() +
                                                '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                + '</div>' +
                                                '</div>'
                                        });

                                        errorFileStr = '<div class="clearfix"><span style="float: left;width: 105px;font-size: 16px; color: #666;">异常原因材料:</span><div style="float:left;width: calc(100% - (131px));">' + str + '</div></div>';
                                    }
                                    return errorFileStr;
	                                }()
	                            +
                                '                <p style="background: #f2f2f2">相关信息</p></div>\n' +
                                /*'                <div style="margin: 15px auto;">\n' +
                                '                    <button type="button" class="layui-btn layui-btn-sm btn" style="">流程</button>\n' +
                                '                    <button type="button" class="layui-btn layui-btn-sm btn">附件</button>\n' +
                                '                    <button type="button" class="layui-btn layui-btn-sm btn">项目</button>\n' +
                                '                    <button type="button" class="layui-btn layui-btn-sm btn">子任务</button>\n' +
                                '                </div>\n' +*/
								'<iframe id="iframeName" src="/ProjectDaily/targetInfor" style="width: 100%;" frameborder="0"></iframe>'+
                                '            </form>'
							$('.right').html(strs)
							$('#iframeName').height($('#rightShow').height()-$('#rightHead').height()-35)

							/*获取当前行的数据*/
							var $str=$('<input type="hidden" id="hiddenDeptId" deptId="'+deptId+'" projectId="'+function () {
								if(res.object.projectId){
									return res.object.projectId
								}else{
									return  ''
								}
							}()+'"   pbagId="'+function () {
								if(res.object.pbagId){
									return res.object.pbagId
								}else{
									return  ''
								}
							}()+'" deptOrProject="'+res.object.deptOrProject+'">')
							$str.data('data',res.object)
							$('.right').append($str)

                            //判断是否已经提交审核过了，提交审核过后按钮不可操作
                            /*if (itemApprivalStatus == 1 || itemApprivalStatus == 2 || itemApprivalStatus == 3 || itemApprivalStatus === '0') {
                                $('.today').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                                $('.Collaborator').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                                $('.transfer').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                                $('#submit').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                            }*/
                            //判断是否可以提交审核
                            /*var isSubmit = isCheck()
                            if (isSubmit == 1) {
                                $('#submit').css('cursor', 'not-allowed')
                                $('.Collaborator').css('cursor', 'not-allowed')
                                $('.transfer').css('cursor', 'not-allowed')
                            } else {
                                $('#submit').css('cursor', 'default')
								$('.Collaborator').css('cursor', 'default')
								$('.transfer').css('cursor', 'default')
                            }*/
							dayReport = '';

                            // 显示每日填报情况
                            for (var i = 0; i < data.length; i++) {

                                // 成果材料附件
								var rusultFileStr = '';
                                if (!!data[i].attachmentList && data[i].attachmentList.length > 0) {
                                    var str = '';
                                    var str_1 = '';

                                    data[i].attachmentList.forEach(function(item){
                                        var attachName = item.attachName;
                                        var fileExtension=attachName.substring(attachName.lastIndexOf(".")+1,attachName.length);//截取附件文件后缀
                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                        var attachmentUrl = item.attUrl;
                                        attachmentUrl = attachmentUrl.substring(0,attachmentUrl.lastIndexOf("ATTACHMENT_NAME="))+"ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension; //处理附件名字

	                                    fileExtension = fileExtension.toLowerCase();

                                        str+= '<div class="divShow"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">'+item.attachName+'</a>' +
                                            '<div class="operationDiv">'+function(){
                                                if(fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                }else{
                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                }
                                            }()+
                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                            +'</div>' +
                                            '</div>'
										str_1+= '<tr><td nowrap width="90">'+data[i].ctreateTime+'</td><td><div class="divShow" style="width: 92%"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">'+item.attachName+'</a>' +
												'<div class="operationDiv">'+function(){
													if(fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
														return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
													}else{
														return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
													}
												}()+
												'<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
												+'</div>' +
												'</div>' +
												function (){
													if($('.layui-this').text()=='正进行'){
														return  '<button type="button" class="layui-btn layui-btn-sm fileDel" deUrl="'+item.attUrl+'">删除</button>'
													}else{
														return ''
													}
												}()+
												'</td></tr>'
                                    });

                                    rusultFileStr = '<div class="clearfix"><span style="width: 70px;float: left;">成果材料：</span><div style="float:left;width: calc(100% - (70px));">'+str+'</div></div>';
									successFileStr+=str_1
                                }

                                // 异常原因附件
								var unusualFIleStr = '';
                                if (!!data[i].attachmentList2 && data[i].attachmentList2.length > 0) {
                                    var str = '';
                                    var str_1 = '';

                                    data[i].attachmentList2.forEach(function(item){
                                        var attachName = item.attachName;
                                        var fileExtension=attachName.substring(attachName.lastIndexOf(".")+1,attachName.length);//截取附件文件后缀
                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                        var attachmentUrl = item.attUrl;
                                        attachmentUrl = attachmentUrl.substring(0,attachmentUrl.lastIndexOf("ATTACHMENT_NAME="))+"ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension; //处理附件名字

	                                    fileExtension = fileExtension.toLowerCase();

                                        str+= '<div class="divShow"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">'+item.attachName+'</a>' +
                                            '<div class="operationDiv">'+function(){
                                                if(fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                }else{
                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                }
                                            }()+
                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                            +'</div>' +
                                            '</div>'
										str_1+= '<tr><td nowrap width="90">'+data[i].ctreateTime+'</td><td><div class="divShow" style="width: 92%"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">'+item.attachName+'</a>' +
												'<div class="operationDiv">'+function(){
													if(fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
														return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
													}else{
														return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
													}
												}()+
												'<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
												+'</div>' +
												'</div>' +
												function (){
													if($('.layui-this').text()=='正进行'){
														return  '<button type="button" class="layui-btn layui-btn-sm fileDel" deUrl="'+item.attUrl+'">删除</button>'
													}else{
														return ''
													}
												}()+
												'</td></tr>'
                                    });

                                    unusualFIleStr = '<div class="clearfix"><span style="width: 100px;float: left;">异常原因材料：</span><div style="float:left;width: calc(100% - (100px));">'+str+'</div></div>';
									failFIleStr+=str_1
                                }

                                dayReport += '<div style="border: 1px solid #d9d6d6;margin-bottom: 10px;position: relative;">\n' +
										function () {
											if($('.layui-this').text()=='正进行'){
												return    '<button type="button" class="layui-btn layui-btn-sm delReport" dailyId="'+data[i].dailyId+'" deptId="'+data[i].deptId+'" style="position: absolute;right: 0px;top: 2px;">删除</button>'
											}else{
												return ''
											}
										}()+
                                    '<div style="overflow: hidden"><div style="float: left;width: 50%;">每日填报人：' + empty(data[i].ctreateUserName) + '</div>' +
                                    '<div style="float: left;width: 50%;">时间：' + empty(data[i].ctreateTime) + '</div></div>' +
                                    '<div style="overflow: hidden"><div style="float: left;width: 50%;">增加协作人：' + empty(data[i].assistUserName) + '</div>' +
                                    '<div style="float: left;width: 50%;">当日完成量：' + function () {
                                        if (data[i].assistUserName || data[i].transfer) {
                                            return '—'
                                        } else {
                                            return data[i].tadayProgress + '%'
                                        }
                                    }() + '</div></div>' +
                                    '<div>转办：' + empty(data[i].transferName) + '</div>' +
                                    '<div>进展日志：' + empty(data[i].tadayDesc) + '</div>' +rusultFileStr+function () {
		                                if (!!data[i].unusualReason) {
		                                    return '<div>异常原因：'+data[i].unusualReason+'</div>'
		                                } else {
		                                    return '';
		                                }
                                    }()
		                                + unusualFIleStr +
                                    '</div>'
                            }

                            //相关信息-最终成果附件（成果、异常）显示
							var object=res.object
							//判断主项关键任务是中心、区域或总承包部
							if($('#allId').attr('deptType')==2){ //区域
								var finalResultFileList = object.attachments5 || '';
								var finalErrorFileList = object.attachments7 || '';
							}else if($('#allId').attr('deptType')==3){ //总承包部
								var finalResultFileList = object.attachments6 || '';
								var finalErrorFileList = object.attachments8 || '';
							}else{
								var finalResultFileList = object.attachments2 || '';
								var finalErrorFileList = object.attachments3 || '';
							}
							// 成果材料附件
							if (!!finalResultFileList && finalResultFileList.length > 0) {
								var str_1 = '';

								finalResultFileList.forEach(function(item){
									var attachName = item.attachName;
									var fileExtension=attachName.substring(attachName.lastIndexOf(".")+1,attachName.length);//截取附件文件后缀
									var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
									var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
									var attachmentUrl = item.attUrl;
									attachmentUrl = attachmentUrl.substring(0,attachmentUrl.lastIndexOf("ATTACHMENT_NAME="))+"ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension; //处理附件名字

									fileExtension = fileExtension.toLowerCase();

									str_1+= '<tr><td colspan="2"><div class="divShow" style="width: 92%"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">'+item.attachName+'</a>' +
											'<div class="operationDiv">'+function(){
												if(fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
													return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
												}else{
													return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
												}
											}()+
											'<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
											+'</div>' +
											'</div>' +
											function (){
												if($('.layui-this').text()=='正进行'){
													return  '<button type="button" class="layui-btn layui-btn-sm fileDel" deUrl="'+item.attUrl+'">删除</button>'
												}else{
													return ''
												}
											}()+
											'</td></tr>'
								});

								finalSuccessFileStr+=str_1
							}

							// 异常原因附件
							if (!!finalErrorFileList && finalErrorFileList.length > 0) {
								var str_1 = '';

								finalErrorFileList.forEach(function(item){
									var attachName = item.attachName;
									var fileExtension=attachName.substring(attachName.lastIndexOf(".")+1,attachName.length);//截取附件文件后缀
									var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
									var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
									var attachmentUrl = item.attUrl;
									attachmentUrl = attachmentUrl.substring(0,attachmentUrl.lastIndexOf("ATTACHMENT_NAME="))+"ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension; //处理附件名字

									fileExtension = fileExtension.toLowerCase();

									str_1+= '<tr><td colspan="2"><div class="divShow" style="width: 92%"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">'+item.attachName+'</a>' +
											'<div class="operationDiv">'+function(){
												if(fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
													return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
												}else{
													return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
												}
											}()+
											'<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
											+'</div>' +
											'</div>' +
											function (){
												if($('.layui-this').text()=='正进行'){
													return  '<button type="button" class="layui-btn layui-btn-sm fileDel" deUrl="'+item.attUrl+'">删除</button>'
												}else{
													return ''
												}
											}()+
											'</td></tr>'
								});

								finalFailFIleStr+=str_1
							}

                            $('.today').on("click",function () {
                                //判断是否已经提交审核过了，提交审核过后按钮不可操作
                                /*if (itemApprivalStatus == 1 || itemApprivalStatus == 2 || itemApprivalStatus == 3 || itemApprivalStatus === '0' || $('.layui-this').text()=='已完成') {
                                    return false
                                }*/
								if($('.layui-this').text()=='已完成') {
									return false
								}
                                layer.open({
                                    type: 1,
                                    title: '今日进展',
                                    shade: 0.3,
                                    area: ['750px', '450px'],
                                    content: '<div style="padding: 15px;"  class="progress">\n' +
                                        '        <form class="layui-form" action="">\n' +
                                        '            <div>\n' +
                                        '                <span style="margin-right: 40px;margin-left:2px">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称:</span>\n' +
                                        '                <span>' + $('#rightName').text() + '</span>\n' +
                                        '            </div>\n' +
                                      /*  '            <div>\n' +
                                        '                <label class="layui-form-label" style="margin: 2px 0px 1px -29px;">进展状态</label>\n' +
                                        '                <div class="layui-input-block">\n' +
                                        '                    <input type="radio" name="doStatus" value="1" lay-skin="primary" title="正常" checked>\n' +
                                        '                    <input type="radio" name="doStatus" value="2" lay-skin="primary" title="延迟">\n' +
                                        '                    <input type="radio" name="doStatus" value="3" lay-skin="primary" title="完成">\n' +
                                        '                    <input type="radio" name="doStatus" value="4" lay-skin="primary" title="暂停">\n' +
                                        '                    <input type="radio" name="doStatus" value="5" lay-skin="primary" title="关闭">\n' +
                                        '                </div>\n' +
                                        '            </div>\n' +*/
                                        '            <div class="layui-form-item" style="margin-top: 12px;">\n' +
                                        '                <div class="layui-inline" style="width: 38%;">\n' +
                                        '                    <label class="layui-form-label" style="margin-left: -6px;width: 90px;padding:9px 0px">今日完成量:</label>\n' +
                                        '                    <div class="layui-input-inline" style="width: 50%;margin-left:24px">\n' +
                                        '                        <input type="tel" name="completion"  oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" lay-verify="required|phone" autocomplete="off" class="layui-input complet" style="height: 33px;display:inline-block;width:80%">%\n' +
                                        '                    </div>\n' +
                                        '                </div>\n' +
                                        '                <div class="layui-inline">\n' +
                                        '                    <label class="layui-form-label" style="width: 120px;margin-left: -46px;margin-top: -9px;">累计完成百分比</label>\n' +
                                        '                    <div class="layui-input-inline">\n' +
                                        '                        <span id="allpro">' + $('.completeQuantity').text() + '</span>\n' + '%' +
                                        '                    </div>\n' +
                                        '                </div>\n' +
                                        '            </div>\n' +
                                        '            <div style="margin-top: -11px;margin-bottom: 18px;">\n' +
                                        '                <span>成果标准模板:</span>\n' +
                                        '                <span>' + function () {
                                            var resultDictList = ''
                                            if (resultDict) {
                                                resultDict.forEach(function (item) {
                                                    resultDictList += item.dictName + ','
                                                })
                                                return resultDictList.replace(/,$/, '')
                                            } else {
                                                return ''
                                            }
                                        }() + '</span>\n' +
                                        '            </div>\n' +
                                        '            <div>\n' +
                                        '                <span>进展情况:</span>\n' +
                                        '                <textarea  name="tadayDesc" class="layui-textarea Desc" style="width: 80%;display: inline;vertical-align: middle;margin-left:37px;"></textarea>\n' +
                                        '            </div>\n' +
											' <div class="layui-form-item"  style="margin-top:15px">\n' +
											'    <label class="layui-form-label" style="width: 117px;margin-left:-20px;padding:3px 15px">提交的成果资料:</label>\n' +
											'    <div class="layui-input-block">\n' +
											' <div id="fileAll">\n' +
											'</div>\n' +
											'<a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
											'<img src="../img/mg11.png" alt="">\n' +
											'<span><fmt:message code="email.th.addfile"/></span>\n' +
											'<input type="file" multiple id="upload" data-url="/upload?module=plancheck" name="file">\n' +
											'</a>\n' +
											'<div class="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">\n' +
											'<div class="bar" style="width: 0%;"></div>\n' +
											'</div>\n' +
											'<div class="barText" style="float: left;margin-left: 10px;"></div>'+
											'</div>\n' +
											'</div>' +
                                        '            <div  style="margin-top:15px">\n' +
                                        '                <label class="layui-form-label" style="margin: 0px 25px 0px -30px;">异常原因:</label>\n' +
                                        '                <div class="layui-input-inline" style="width: 80%">\n' +
                                        '                    <input type="text" name="unusualReason"  autocomplete="off" class="layui-input Reason">\n' +
                                        '                </div>\n' +
                                        '            </div>\n' +
                                        ' <div class="layui-form-item"  style="margin-top:15px">\n' +
                                        '    <label class="layui-form-label" style="width: 100px;margin-left:-20px;padding:3px 15px">异常支撑资料:</label>\n' +
                                        '    <div class="layui-input-block">\n' +
                                        ' <div id="filerror">\n' +
                                        '</div>\n' +
                                        '<a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                                        '<img src="../img/mg11.png" alt="">\n' +
                                        '<span><fmt:message code="email.th.addfile"/></span>\n' +
                                        '<input type="file" multiple id="fileupload" data-url="/upload?module=plancheck" name="file">\n' +
                                        '</a>\n' +
										'<div class="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">\n' +
											'<div class="bar" style="width: 0%;"></div>\n' +
											'</div>\n' +
											'<div class="barText" style="float: left;margin-left: 10px;"></div>'+
                                        '</div>\n' +
                                        '</div>' +
                                        '        </form>\n' +
                                        '    </div>',
                                    // btn: ['保存', '提交审核', '取消'],
	                                btn: ['保存', '取消'],
                                    success: function (res) {
                                        fileuploadFn('#fileupload', $('#filerror'));
                                        fileuploadFn('#upload', $('#fileAll'));
                                        form.render()
                                    },
                                    yes: function (index) {
										var loadIndex = layer.load();
                                        var completeQuantity = parseInt($('.complet').val()) + parseInt($('.completeQuantity').text())
                                        if (completeQuantity > 100) {
                                            layer.msg('今日完成量和累计完成百分比相加不能超过100', {icon: 0, time: 1000});
                                            return false;
                                        }
                                        if ($('.complet').val() == '') {
                                            layer.msg('请填写今日完成量!', {icon: 0, time: 1000});
											layer.close(loadIndex);
											return false
                                        }
                                        if ($('.Desc').val() == '') {
                                            layer.msg('请填写进展情况!', {icon: 0, time: 1000});
											layer.close(loadIndex);
											return false
                                        }
                                        var obj = {}
                                        //成果附件
                                        var attachmentId = '';
                                        var attachmentName = '';
                                        for (var i = 0; i < $('#fileAll .dech').length; i++) {
                                            attachmentId += $('#fileAll .dech').eq(i).find('input').val();
                                            attachmentName += $('#fileAll a').eq(i).attr('name');
                                        }
                                        //异常支撑材料
                                        var attachmentId2 = '';
                                        var attachmentName2 = '';
                                        for (var i = 0; i < $('#filerror .dech').length; i++) {
                                            attachmentId2 += $('#filerror .dech').eq(i).find('input').val();
                                            attachmentName2 += $('#filerror a').eq(i).attr('name');
                                        }
                                        obj.taskName = $('#rightName').text()
                                        obj.attachmentId = attachmentId
                                        obj.attachmentName = attachmentName
                                        obj.attachmentId2 = attachmentId2
                                        obj.attachmentName2 = attachmentName2
                                        obj.completeQuantity = completeQuantity //累计完成量
                                        obj.tadayProgress = parseInt($('.complet').val())//今日完成量
                                        obj.unusualReason = $('.Reason').val() //异常原因
                                        obj.tadayDesc = $('.Desc').val()  //进展情况
                                        obj.doStatus = $('input[name="doStatus"]:checked').val() //进展状态
                                        obj.tgId = tgId
	                                    obj.deptId = deptId
	                                    obj.deptType=$('#allId').attr('deptType')
	                                    obj.taskStatus=$('#allId').attr('taskStatus')
                                        $.ajax({
                                            url: '/ProjectDaily/submit',
                                            dataType: 'json',
                                            type: 'post',
                                            data: obj,
                                            success: function (res) {
												layer.close(loadIndex);
                                                if (res.flag) {
                                                    layer.msg('保存成功！', {icon: 1});
                                                    layer.close(index)
													$('.layui_tr_active').trigger('click')
                                                }
                                            }
                                        })
                                    },
                                    btn2: function (index) {
                                        layer.close(index)
                                    }
                                })
                            })
                            $('.Collaborator').on("click",function () {
                            	//只有当前登录人是负责人才可增加协作人
								/*var isSubmit = isCheck()
								if (isSubmit == 1) {
									return false
								}*/
                                //判断是否已经提交审核过了，提交审核过后按钮不可操作
                                /*if (itemApprivalStatus == 1 || itemApprivalStatus == 2 || itemApprivalStatus == 3 || itemApprivalStatus === '0' || $('.layui-this').text()=='已完成') {
                                    return false
                                }*/
								if ($('#allId').attr('assistanceStatus')==1 || $('.layui-this').text()=='已完成') {
									return false
								}
                                layer.open({
                                    type: 1,
                                    title: '增加协作人',
                                    area: ['450px', '250px'],
                                    content: '<form style="margin-top: 20px">' +
                                        '<div class="layui-inline">\n' +
                                        '                    <label class="layui-form-label"><span style="color: red;">*</span>协作人</label>\n' +
                                        '                    <div class="layui-input-inline">\n' +
                                        '                        <textarea  id="resUser" user_id="" readonly style="background: #e7e7e7" class="layui-textarea"></textarea>\n' +
                                        '                    </div>\n' +
                                        '                    <a href="javascript:;" style="color:#1E9FFF" class="add">添加</a>\n' +
                                        '                    <a href="javascript:;" style="color:#1E9FFF" class="Execute">清空</a>\n' +
                                        '                </div>' +
                                        '</form>',
                                    btn: ['确认', '返回'],
                                    success: function (res) {
                                        $(".add").on("click", function () {
                                            user_id = "resUser";
                                            $.popWindow("/projectTarget/selectOwnDeptUser");
                                        });

                                        $('.Execute').on("click",function () {
                                            $("#resUser").val("");
                                            $("#resUser").attr('user_id', '');
                                        });
                                    },
                                    yes: function (index) {
										var loadIndex = layer.load();
                                        if (!$('#resUser').val()) {
                                            layer.msg('请选择责任人！', {icon: 0});
											layer.close(loadIndex);
											return false
                                        }
                                        if (tgId) {
                                            var datasPer = {ids: tgId, assistUser: $('#resUser').attr('user_id'),deptId:$('#allId').attr('deptId')}
                                            var url = '/projectTarget/addPeople'
                                        }
                                        $.ajax({
                                            url: url,
                                            dataType: 'json',
                                            type: 'get',
                                            data: datasPer,
                                            success: function (res) {
												layer.close(loadIndex);
												if (res.flag) {
                                                    layer.msg('保存成功！', {icon: 1});
                                                    layer.close(index)
													$('.layui_tr_active').trigger('click')
                                                }
                                            }
                                        })
                                    }
                                })
                            })
                            $('.transfer').on("click",function () {
								//只有当前登录人是负责人才可转办
								/*var isSubmit = isCheck()
								if (isSubmit == 1) {
									return false
								}*/
                                //判断是否已经提交审核过了，提交审核过后按钮不可操作
                              /*  if (itemApprivalStatus == 1 || itemApprivalStatus == 2 || itemApprivalStatus == 3 || itemApprivalStatus === '0' || $('.layui-this').text()=='已完成') {
                                    return false
                                }*/
								if ($('#allId').attr('assistanceStatus')==1 || $('.layui-this').text()=='已完成') {
									return false
								}
                                layer.open({
                                    type: 1,
                                    title: '转办',
                                    area: ['450px', '250px'],
                                    content: '<form style="margin-top: 20px">' +
                                        '<div class="layui-inline">\n' +
                                        '                    <label class="layui-form-label"><span style="color: red;">*</span>责任人</label>\n' +
                                        '                    <div class="layui-input-inline">\n' +
                                        '                        <textarea  id="transferUser" user_id="" readonly style="background: #e7e7e7" class="layui-textarea"></textarea>\n' +
                                        '                    </div>\n' +
                                        '                    <a href="javascript:;" style="color:#1E9FFF" class="add">添加</a>\n' +
                                        '                    <a href="javascript:;" style="color:#1E9FFF" class="Execute">清空</a>\n' +
                                        '                </div>' +
                                        '</form>',
                                    btn: ['确认', '返回'],
                                    success: function (res) {
                                        $(".add").on("click", function () {
                                            user_id = "transferUser";
                                            $.popWindow("/projectTarget/selectOwnDeptUser?0");
                                        });

                                        $('.Execute').on("click",function () {
                                            $("#transferUser").val("");
                                            $("#transferUser").attr('user_id', '');
                                        });
                                    },
                                    yes: function (index) {
										var loadIndex = layer.load();
                                        if (!$('#transferUser').val()) {
                                            layer.msg('请选择责任人！', {icon: 0});
											layer.close(loadIndex);
                                            return false
                                        }
                                        if (tgId) {
                                            var datasPer = {
                                                ids: tgId,
                                                dutyUser: $('#transferUser').attr('user_id'),
                                                deptId: $('#allId').attr('deptId'),
                                                deptType: $('#allId').attr('deptType')
                                            }
                                            var url = '/projectTarget/changeDutyUser'
                                        }
                                        $.ajax({
                                            url: url,
                                            dataType: 'json',
                                            type: 'get',
                                            data: datasPer,
                                            success: function (res) {
												layer.close(loadIndex);
                                                if (res.flag) {
                                                    layer.msg('保存成功！', {icon: 1});
                                                    layer.close(index)
													$('.layui_tr_active').trigger('click')
                                                }
                                            }
                                        })
                                    }
                                })
                            })

                            if (authorityObject) {
                                // 今日
                                if (authorityObject['13']) {
                                    $('.today').show();
                                }
                                // 增加协作人
                                if (authorityObject['14']) {
                                    $('.Collaborator').show();
                                }
                                // 转办
                                if (authorityObject['15']) {
                                    $('.transfer').show();
                                }
                                // 提交考核
                                if (authorityObject['16']) {
                                    $('#submit').show();
                                }
                            }
                        }
                    })
                }

                //判断是否可以提交审核----返回1是不可以提交审核
                function isCheck() {
                    var isOk = ''
                    var urlSubmit = '/projectTarget/checkDutyUser'
                    $.ajax({
                        url: urlSubmit,
                        data: {id: $('#allId').val(), deptId: $('#allId').attr('deptId')},
                        dataType: 'json',
                        type: 'get',
                        async: false,
                        success: function (res) {
                            if (res.flag && res.code != 1) {
                                isOk = 1
                            }
                        }
                    })
                    return isOk
                }

                //提交审核
                $(document).on('click', '#submit', function () {
                   /* var isSubmit = isCheck()
                    //判断是否已经提交审核过了，提交审核过后按钮不可操作
                    var itemApprivalStatus = $('#allId').attr('itemApprivalStatus')
                    if (itemApprivalStatus == 1 || itemApprivalStatus == 2 || itemApprivalStatus == 3 || itemApprivalStatus === '0'|| isSubmit == 1 || $('.layui-this').text()=='已完成') {
                        return false
                    }*/
					if ($('#allId').attr('assistanceStatus')==1 || $('.layui-this').text()=='已完成') {
						return false
					}
					//判断累计完成百分比是否达到100
					if($('.completeQuantity').text() < 100){
						layer.confirm('累计完成百分比还没达到100%，是否继续提交审核？', {
							btn: ['继续提交审核', '继续填报', '取消'] //可以无限个按钮
							,btn3: function(index, layero){
								//按钮【按钮三】的回调
							}
						}, function(index, layero){
							goSubmit()
						}, function(index){
							layer.close(index)
							$('.today').trigger('click')
						});
					}else{
						goSubmit()
					}
                })

				function goSubmit(){
					layer.open({
						title: '提交审核',
						type: 1,
						btn: ['提交', '取消'],
						shade: 0.3,
						area: ['750px', '450px'],
						content: '<div style="padding: 15px;" class="progress">\n' +
								'        <form class="layui-form">\n' +
								'            <div>\n' +
								'                <span style="margin-right: 32px;">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</span>\n' +
								'                <span>' + $('#rightName').text() + '</span>\n' +
								'            </div>\n' +
								/*'            <div style="margin-top:15px">\n' +
								'                <label class="layui-form-label" style="width:113px;margin-left:-8px;padding:9px 6px">实际开始时间：</label>\n' +
								'                <div class="layui-input-inline" style="width: 80%">\n' +
								' <input type="text" class="layui-input" name="realStartDate" id="realStartDate">' +
								'                </div>\n' +
								'            </div>\n' +
								'            <div style="margin-top:15px">\n' +
								'                <label class="layui-form-label" style="width:113px;margin-left:-8px;padding:9px 6px">实际完成时间：</label>\n' +
								'                <div class="layui-input-inline" style="width: 80%">\n' +
								' <input type="text" class="layui-input" name="realEndDate" id="realEndDate">' +
								'                </div>\n' +
								'            </div>\n' +*/
								'            <div class="layui-form-item" style="margin-top: 12px;margin-bottom:0px">\n' +
								'                <div class="layui-inline">\n' +
								'                    <label class="layui-form-label" style="width: 130px;margin-top: -9px;margin-left: -18px;">累计完成百分比：</label>\n' +
								'                    <div class="layui-input-inline">\n' +
								'                        <span id="allpro">' + $('.completeQuantity').text() + '</span>\n' + '%' +
								'                    </div>\n' +
								'                </div>\n' +
								'            </div>\n' +
								'           <div class="layui-form-item" style="margin-bottom:0px">\n' +
								'               <label class="layui-form-label" style="width: 120px;margin-left: -24px;padding:3px 15px">最终成果资料：</label>\n' +
								'               <div class="layui-input-block" style="padding-left: 15px;">\n' +
								'                   <div id="fileAll"></div>\n' +
								'							  <a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
								'                       <img src="../img/mg11.png" alt="">\n' +
								'                       <span><fmt:message code="email.th.addfile"/></span>\n' +
								'                       <input type="file" multiple id="upload" data-url="/upload?module=plancheck" name="file">\n' +
								'                   </a>\n' +
								'<div class="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">\n' +
								'<div class="bar" style="width: 0%;"></div>\n' +
								'</div>\n' +
								'<div class="barText" style="float: left;margin-left: 10px;"></div>'+
								'               </div>\n' +
								'           </div>' +
								'            <div>\n' +
								'                <label class="layui-form-label" style="margin: 0px 25px 0px -16px;">异常原因：</label>\n' +
								'                <div class="layui-input-inline" style="width: 80%">\n' +
								'                    <input type="text" name="unusualRes" id="unusualRes" autocomplete="off" class="layui-input Reason">\n' +
								'                </div>\n' +
								'            </div>\n' +
								'            <div class="layui-form-item" style="margin-top:15px">\n' +
								'               <label class="layui-form-label" style="width: 120px;margin-left: -24px;padding:3px 15px">异常支撑资料：</label>\n' +
								'               <div class="layui-input-block" style="padding-left: 15px;">\n' +
								'                   <div id="fileError"></div>\n' +
								'							<a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
								'                       <img src="../img/mg11.png" alt="">\n' +
								'                       <span><fmt:message code="email.th.addfile"/></span>\n' +
								'                       <input type="file" multiple id="fileupload" data-url="/upload?module=plancheck" name="file">\n' +
								'                   </a>\n' +
								'<div class="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">\n' +
								'<div class="bar" style="width: 0%;"></div>\n' +
								'</div>\n' +
								'<div class="barText" style="float: left;margin-left: 10px;"></div>'+
								'               </div>\n' +
								'           </div>' +
								'<div class="layui-form-item">\n' +
								'    <div class="layui-input-block" style="margin-left: 120px;">\n' +
								'      <input type="checkbox" name="remind" title="事务提醒" lay-skin="primary" checked>\n' +
								'      <input type="checkbox" name="smsRemind" title="短信提醒"  lay-skin="primary">\n' +
								'    </div>\n' +
								'  </div>'+
								'        </form>\n' +
								'    </div>',
						success: function () {
							form.render()
							fileuploadFn('#upload', $('#fileAll'));
							fileuploadFn('#fileupload', $('#fileError'));
							/*var now = new Date();
							now.setTime(now.getTime());
							var today = now.getFullYear()+"-" + (now.getMonth()+1) + "-" + now.getDate();
							/!*实际开始时间*!/
							var planStartLaydateConfig = {
								elem: '#realStartDate',
								max:today,
								done: function (value, date) {
									if (planEndLaydate.config.min) {
										// 修改开始时间最大选择日期
										planEndLaydate.config.min = {
											year: date.year || 1900,
											month: date.month - 1 || 0,
											date: date.date || 1,
										}
									} else {
										planEndLaydateConfig.min = value;
									}
								},
								trigger: 'click' //采用click弹出
							}
							var planStartLaydate = laydate.render(planStartLaydateConfig);

							/!*实际完成时间*!/
							var planEndLaydateConfig = {
								elem: '#realEndDate',
								max:today,
								done: function (value, date) {
									if (planStartLaydate.config.max) {
										// 修改开始时间最大选择日期
										planStartLaydate.config.max = {
											year: date.year || 2099,
											month: date.month - 1 || 11,
											date: date.date || 31,
										}
									} else {
										planStartLaydateConfig.max = value;
									}
								},
								trigger: 'click' //采用click弹出
							}
							var planEndLaydate = laydate.render(planEndLaydateConfig);*/
						},
						yes: function (index) {
							/*if(!$('#realStartDate').val() || !$('#realEndDate').val()){
								layer.msg('请选择实际开始时间/实际完成时间', {icon: 0, time: 1000});
								return false;
							}*/
							var loadingIndex = layer.load(0);

							var updateData = {
								taskPrecess: $('.completeQuantity').text(),
								itemApprivalStatus: 0,
								taskStatus: 5,
								deptType:$('#allId').attr('deptType')
							}

							//成果附件
							var attachmentId2 = '';
							var attachmentName2 = '';
							for (var i = 0; i < $('#fileAll .dech').length; i++) {
								attachmentId2 += $('#fileAll .dech').eq(i).find('input').val();
								attachmentName2 += $('#fileAll a').eq(i).attr('name');
							}

							if (!attachmentId2) {
								layer.close(loadingIndex);
								layer.msg('请提交最终成果材料', {icon: 0, time: 1000});
								return false;
							}

							//异常支撑材料
							var attachmentId3 = '';
							var attachmentName3 = '';
							for (var i = 0; i < $('#fileError .dech').length; i++) {
								attachmentId3 += $('#fileError .dech').eq(i).find('input').val();
								attachmentName3 += $('#fileError a').eq(i).attr('name');
							}

							//判断主项关键任务是中心、区域或总承包部
							var deptType=$('#allId').attr('deptType')
							if(deptType==2){ //区域
								updateData.attachmentId5=attachmentId2
								updateData.attachmentName5=attachmentName2
								updateData.areaUnusualStuff=$('#unusualRes').val()
								updateData.attachmentId7=attachmentId3
								updateData.attachmentName7=attachmentName3
								/*updateData.areaStartDate=$('#realStartDate').val()
								updateData.areaEndDate=$('#realEndDate').val()*/
							}else if(deptType==3){  //总承包部
								updateData.attachmentId6=attachmentId2
								updateData.attachmentName6=attachmentName2
								updateData.projectUnusualStuff=$('#unusualRes').val()
								updateData.attachmentId8=attachmentId3
								updateData.attachmentName8=attachmentName3
								/*updateData.projectStartDate=$('#realStartDate').val()
								updateData.projectEndDate=$('#realEndDate').val()*/
							}else{
								updateData.attachmentId2=attachmentId2
								updateData.attachmentName2=attachmentName2
								updateData.unusualRes=$('#unusualRes').val()
								updateData.attachmentId3=attachmentId3
								updateData.attachmentName3=attachmentName3
								/*updateData.realStartDate=$('#realStartDate').val()
								updateData.realEndDate=$('#realEndDate').val()*/
							}

							var updateUrl = '/projectTarget/submit';
							var contentShow=''
							if ($('.targetOrItem  .layui-this').text() == '正进行') {
								contentShow=1
							} else {
								contentShow=2
							}
							updateData.tgId = $('#allId').val();
							/*事务提醒和短信提醒*/
							var remind
							var smsRemind
							if($('input[name="remind"]').prop('checked')){
								updateData.remind=1
							}else{
								updateData.remind=0
							}
							if($('input[name="smsRemind"]').prop('checked')){
								updateData.smsRemind=1
							}else{
								updateData.smsRemind=0
							}
							/*判断是主项关键任务时才传deptId*/
							if($('#hiddenDeptId').attr('projectId')!='' || $('#hiddenDeptId').attr('pbagId')!=''){
								// updateData.deptId=getDeptId()
								updateData.planClass=1
							}else{
								// updateData.deptId=$('#hiddenDeptId').data('data').targetBelongDept
								updateData.planClass=2
							}
							updateData.deptId=$('#hiddenDeptId').attr('deptId')

							$.post(updateUrl, updateData, function(res){
								layer.close(loadingIndex);
								if (res.flag) {
									layer.close(index);
									layer.msg('提交审核成功', {icon: 1, time: 1000});
									// tableShow(contentShow);
									window.location.reload()
								} else {
									layer.msg('提交审核失败', {icon: 2, time: 1000});
								}
							});
						}
					});
				}
                // 查询
                $('.search').on("click",function () {
					var complete=''
					if ($('.targetOrItem  .layui-this').text() == '正进行') {
						complete=1
					} else {
						complete=2
					}
					var tgName = $('input[name="tgName"]').val(),
                        mainCenterDept = $('.deptName').val(),
                        year = $('select[name="year"]').val(),
                        month = $('select[name="month"]').val(),
                        planType = $('.planType').val();
					tableInit.reload({
						page: {
							curr: 1
						},
						where: {
							complete: complete,
							allocationStatus:1,
							_:new Date().getTime(),
							useFlag:true,
							tgName:tgName,
							mainCenterDept:mainCenterDept,
							year:year,
							month:month,
							planType:planType,
						}
					})
                })
                //重置的按钮
                $('.clear').on("click",function () {
                    $('.query input').val('')
                    $('.query select').val('')
                    form.render()
                })

                $(document).on('click', '#rightName', function () {
                    var tgId = $(this).attr('tgId')
	                var deptId = $(this).attr('deptId')
                    $.ajax({
                        url: '/ProjectDaily/selectProjectDailyByItemId',
                        dataType: 'json',
                        type: 'get',
                        data: {tgId: tgId,deptId:deptId},
                        success: function (res) {
                            var data = res.data;
                            var targetData = res.object;

                            layer.open({
                                type: 1,
                                title: '关键任务详情',
                                area: ['70%', '90%'],
                                maxmin: true,
                                min: function () {
                                    $('.layui-layer-shade').hide()
                                },
                                content: '<div id="target_detail" style="margin:10px"></div>',
                                success: function () {
                                    var dayReport = '';

                                    if (!!targetData) {
                                        var str = ''
                                        if (targetData.deptOrProject == 0) {
                                            str = '<tr>' +
	                                        '<td class="td_title">区域责任人</td>' +
											'<td colspan="1">' + isShowNull(targetData.mainAreaUserName).replace(/,$/, '') + '</td>' +
											'<td class="td_title">区域责任部门</td>' +
											'<td colspan="3">' + isShowNull(targetData.mainAreaDeptName).replace(/,$/, '') + '</td>' +
											'</tr>' +
	                                        '<tr>' +
                                            '<td class="td_title">区域实际开始时间</td>' +
                                            '<td colspan="1">' + format(targetData.areaStartDate) + '</td>' +
                                            '<td class="td_title">区域实际结束时间</td>' +
                                            '<td colspan="3">' + format(targetData.areaEndDate) + '</td>' +
	                                        '</tr>' +
	                                        '<tr>' +
                                            '<td class="td_title">区域需提交的成果材料</td>' +
                                            '<td colspan="5">' +
                                            function () {
                                                if (!!targetData.attachments5 && targetData.attachments5.length > 0) {
                                                    var str = '';

                                                    targetData.attachments5.forEach(function (item) {
                                                        var attachName = item.attachName;
                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                        var attachmentUrl = item.attUrl;
                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                        fileExtension = fileExtension.toLowerCase();

                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                } else {
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                }
                                                            }() +
                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                            + '</div>' +
                                                            '</div>'
                                                    });

                                                    return str;
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">区域异常原因</td>' +
                                            '<td colspan="5">' + isShowNull(targetData.areaUnusualRes) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">区域异常原因材料</td>' +
                                            '<td colspan="5">' +
                                            function () {
                                                if (!!targetData.attachments7 && targetData.attachments7.length > 0) {
                                                    var str = '';

                                                    targetData.attachments7.forEach(function (item) {
                                                        var attachName = item.attachName;
                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                        var attachmentUrl = item.attUrl;
                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                        fileExtension = fileExtension.toLowerCase();

                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                } else {
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                }
                                                            }() +
                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                            + '</div>' +
                                                            '</div>'
                                                    });

                                                    return str;
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>' +
											'<tr>' +
	                                        '<td class="td_title">总承包部责任人</td>' +
											'<td colspan="1">' + isShowNull(targetData.mainProjectUserName).replace(/,$/, '') + '</td>' +
											'<td class="td_title">总承包部责任部门</td>' +
											'<td colspan="3">' + isShowNull(targetData.mainProjectDeptName).replace(/,$/, '') + '</td>' +
											'</tr>' +
											'<tr>' +
                                            '<td class="td_title">总承包部实际开始时间</td>' +
                                            '<td colspan="1">' + format(targetData.projectStartDate) + '</td>' +
                                            '<td class="td_title">总承包部实际结束时间</td>' +
                                            '<td colspan="3">' + format(targetData.projectEndDate) + '</td>' +
	                                        '</tr>' +
	                                        '<tr>' +
                                            '<td class="td_title">总承包部需提交的成果材料</td>' +
                                            '<td colspan="5">' +
                                            function () {
                                                if (!!targetData.attachments6 && targetData.attachments6.length > 0) {
                                                    var str = '';

                                                    targetData.attachments6.forEach(function (item) {
                                                        var attachName = item.attachName;
                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                        var attachmentUrl = item.attUrl;
                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                        fileExtension = fileExtension.toLowerCase();

                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                } else {
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                }
                                                            }() +
                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                            + '</div>' +
                                                            '</div>'
                                                    });

                                                    return str;
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">总承包部异常原因</td>' +
                                            '<td colspan="5">' + isShowNull(targetData.projectUnusualRes) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">总承包部异常原因材料</td>' +
                                            '<td colspan="5">' +
                                            function () {
                                                if (!!targetData.attachments8 && targetData.attachments8.length > 0) {
                                                    var str = '';

                                                    targetData.attachments8.forEach(function (item) {
                                                        var attachName = item.attachName;
                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                        var attachmentUrl = item.attUrl;
                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                        fileExtension = fileExtension.toLowerCase();

                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                } else {
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                }
                                                            }() +
                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                            + '</div>' +
                                                            '</div>'
                                                    });

                                                    return str;
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>'
                                        }

                                        dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;">关键任务详情</h3><table class="layui-table">' +
                                            '<tbody>' +
                                            '<tr>' +
                                            '<td class="td_title">关键任务编号</td>' +
                                            '<td colspan="1">' + isShowNull(targetData.tgNo) + '</td>' +
                                            '<td class="td_title">关键任务名称</td>' +
                                            '<td colspan="3">' + isShowNull(targetData.tgName) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">关注等级</td>' +
                                            '<td colspan="1">' + isShowNull(dictionaryObj['CONTROL_LEVEL']['object'][targetData.controlLevel]) + '</td>' +
                                            '<td class="td_title">周期类型</td>' +
                                            '<td colspan="3">' + isShowNull(dictionaryObj['PLAN_SYCLE']['object'][targetData.planSycle]) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">关键任务类型</td>' +
                                            '<td colspan="1">' + isShowNull(dictionaryObj['TG_TYPE']['object'][targetData.tgType]) + '</td>' +
                                            '<td class="td_title">计划阶段</td>' +
                                            '<td colspan="3">' + isShowNull(dictionaryObj['PLAN_PHASE']['object'][targetData.planStage]) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">设计量</td>' +
                                            '<td colspan="1">' + isShowNull(targetData.designQuantity) + '</td>' +
                                            '<td class="td_title">工程量</td>' +
                                            '<td colspan="3">' + isShowNull(targetData.itemQuantity) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">单位</td>' +
                                            '<td colspan="1">' + isShowNull(dictionaryObj['UNIT']['object'][targetData.itemQuantityNuit]) + '</td>' +
                                            '<td class="td_title">完成标准</td>' +
                                            '<td colspan="3">' + isShowNull(targetData.resultStandard) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">计划开始时间</td>' +
                                            '<td>' +
                                            function () {
                                                if (targetData.planStartDate) {
                                                    return format(targetData.planStartDate)
                                                } else {
                                                    return ''
                                                }
                                            }() +
                                            '</td>' +
                                            '<td class="td_title">计划结束时间</td>' +
                                            '<td>' +
                                            function () {
                                                if (targetData.planEndDate) {
                                                    return format(targetData.planEndDate)
                                                } else {
                                                    return ''
                                                }
                                            }() +
                                            '</td>' +
                                            '<td class="td_title">计划工期</td>' +
                                            '<td>' + isShowNull(targetData.planContinuedDate) + '</td>' +
                                            '</tr>' +
	                                        '<tr>' +
                                            '<td class="td_title">'+(targetData.deptOrProject==0 ?  '中心' : '')+'责任人</td>' +
                                            '<td colspan="1">' + isShowNull(targetData.dutyUserName).replace(/,$/, '') + '</td>' +
                                            '<td class="td_title">'+(targetData.deptOrProject==0 ?  '中心' : '')+'责任部门</td>' +
                                            '<td colspan="3">' + isShowNull(targetData.mainCenterDeptName).replace(/,$/, '') + '</td>' +
                                            '</tr>' +
	                                        '<tr>' +
                                            '<td class="td_title">'+(targetData.deptOrProject==0 ?  '中心' : '')+'实际开始时间</td>' +
                                            '<td colspan="1">' + format(targetData.realStartDate) + '</td>' +
                                            '<td class="td_title">'+(targetData.deptOrProject==0 ?  '中心' : '')+'实际结束时间</td>' +
                                            '<td colspan="3">' + format(targetData.realEndDate) + '</td>' +
	                                        '</tr>' +
	                                        '<tr>' +
                                            '<td class="td_title">'+(targetData.deptOrProject==0 ?  '中心' : '')+'需提交的成果材料</td>' +
                                            '<td colspan="5">' +
                                            function () {
                                                if (!!targetData.attachments2 && targetData.attachments2.length > 0) {
                                                    var str = '';

                                                    targetData.attachments2.forEach(function (item) {
                                                        var attachName = item.attachName;
                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                        var attachmentUrl = item.attUrl;
                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                        fileExtension = fileExtension.toLowerCase();

                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                } else {
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                }
                                                            }() +
                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                            + '</div>' +
                                                            '</div>'
                                                    });

                                                    return str;
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">'+(targetData.deptOrProject==0 ?  '中心' : '')+'异常原因</td>' +
                                            '<td colspan="5">' + isShowNull(targetData.unusualRes) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">'+(targetData.deptOrProject==0 ?  '中心' : '')+'异常原因材料</td>' +
                                            '<td colspan="5">' +
                                            function () {
                                                if (!!targetData.attachments3 && targetData.attachments3.length > 0) {
                                                    var str = '';

                                                    targetData.attachments3.forEach(function (item) {
                                                        var attachName = item.attachName;
                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                        var attachmentUrl = item.attUrl;
                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                        fileExtension = fileExtension.toLowerCase();

                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                } else {
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                }
                                                            }() +
                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                            + '</div>' +
                                                            '</div>'
                                                    });

                                                    return str;
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>' + str +
                                            '<tr>' +
                                            '<td class="td_title">难度系数</td>' +
                                            '<td>' + isShowNull(targetData.hardDegree) + '</td>' +
                                            '<td class="td_title">风险点</td>' +
                                            '<td>' + isShowNull(targetData.riskPoint) + '</td>' +
                                            '<td class="td_title">难度点</td>' +
                                            '<td>' + isShowNull(targetData.difficultPoint) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">成果标准模板</td>' +
                                            '<td colspan="5">' +
                                            function () {
                                                var resultDictName = '';
                                                if (!!targetData.resultDict) {
                                                    var resultDictList = targetData.resultDict.split(',');

                                                    resultDictList.forEach(function (item) {
                                                        resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
                                                    });
                                                }

                                                return resultDictName.replace(/,$/, '');
                                            }() +
                                            '</td>' +
                                            '</tr>' +
												'<tr>' +
												'<td class="td_title">编制依据附件</td>' +
												'<td colspan="5">' +
												function () {
													if (!!targetData.attachments4 && targetData.attachments4.length > 0) {
														var str = '';

														targetData.attachments4.forEach(function (item) {
															var attachName = item.attachName;
															var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
															var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
															var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
															var attachmentUrl = item.attUrl;
															attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

															fileExtension = fileExtension.toLowerCase();

															str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
																	'<div class="operationDiv" style="top: -50px;">' + function () {
																		if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
																			return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
																		} else {
																			return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
																		}
																	}() +
																	'<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
																	+ '</div>' +
																	'</div>'
														});

														return str;
													} else {
														return '';
													}
												}() +
												'</td>' +
												'</tr>' +
                                            '</tbody>' +
                                            '</table>'
                                    }

                                    $('#target_detail').append(dayReport)
                                }
                            })
                        }
                    })
                })
            })

			//子任务详情
			function detail(planItemId){
				$.get('/plcProjectItem/selectById',{planItemId:planItemId},function (res) {
					var data=res.data
					layer.open({
						type: 1,
						title: '子任务详情',
						area: ['70%', '80%'],
						maxmin: true,
						min: function () {
							$('.layui-layer-shade').hide()
						},
						content: '<div style="margin: 10px"><table class="layui-table child" style="margin: 10px 5px;width: 99%">\n' +
								'  <colgroup>\n' +
								'    <col width="150">\n' +
								'    <col >\n' +
								'    <col width="150">\n' +
								'    <col >\n' +
								'  </colgroup>'+
								'  <tbody>\n' +
								'    <tr>\n' +
								'      <td>子任务名称</td>\n' +
								'      <td>'+isShowNull(data.taskName)+'</td>\n' +
								'      <td>关联关键任务</td>\n' +
								'      <td>'+function () {
									var tgIds=''
									if(data.tgIds){
										data.tgIds.forEach(function (item) {
											tgIds+=item.tgName+','
										})
										return tgIds.replace(/,$/, '')
									}else{
										return  ''
									}
								}()+'</td>\n' +
								'    </tr>\n' +
								'    <tr>\n' +
								'      <td>周期类型</td>\n' +
								'      <td>'+isShowNull(dictionaryObj['PLAN_SYCLE']['object'][data.planSycle])+'</td>\n' +
								'      <td>任务来源</td>\n' +
								'      <td>'+isShowNull(dictionaryObj['RENWUJIHUA_TYPE']['object'][data.taskType])+'</td>\n' +
								'    </tr>\n' +
								'    <tr>\n' +
								'      <td>负责人</td>\n' +
								'      <td>'+function () {
									if(data.dutyUserName){
										return isShowNull(data.dutyUserName.replace(/,$/, ''))
									}else{
										return  ''
									}
								}()+'</td>\n' +
								'      <td>责任部门</td>\n' +
								'      <td>'+function () {
									if(data.mainCenterDeptName){
										return isShowNull(data.mainCenterDeptName.replace(/,$/, ''))
									}else{
										return  ''
									}
								}()+'</td>\n' +
								'    </tr>\n' +
								'    <tr>\n' +
								'      <td>计划开始时间</td>\n' +
								'      <td>'+function () {
									if(data.planStartDate){
										return format(data.planStartDate)
									}else{
										return  ''
									}
								}()+'</td>\n' +
								'      <td>计划结束时间</td>\n' +
								'      <td>'+function () {
									if(data.planEndDate){
										return format(data.planEndDate)
									}else{
										return  ''
									}
								}()+'</td>\n' +
								'    </tr>\n' +
								'    <tr>\n' +
								'      <td>计划工期</td>\n' +
								'      <td>'+isShowNull(data.planContinuedDate)+'</td>\n' +
								'      <td>完成标准</td>\n' +
								'      <td>'+isShowNull(data.resultStandard)+'</td>\n' +
								'    </tr>\n' +
								'    <tr>\n' +
								'      <td>前置子任务</td>\n' +
								'      <td>'+function () {
									var preTasks=''
									if(data.preTasks){
										data.preTasks.forEach(function (item) {
											preTasks+=item.workItemName+','
										})
										return preTasks.replace(/,$/, '')
									}else{
										return  ''
									}
								}()+'</td>\n' +
								'      <td>风险点</td>\n' +
								'      <td>'+isShowNull(data.riskPoint)+'</td>\n' +
								'    </tr>\n' +
								'    <tr>\n' +
								'      <td>难度点</td>\n' +
								'      <td>'+isShowNull(data.difficultPoint)+'</td>\n' +
								'      <td>成果标准模板</td>\n' +
								'      <td>'+function () {
									var resultDictList=''
									if(data.resultDictList){
										data.resultDictList.forEach(function (item) {
											resultDictList+=item.dictName+','
										})
										return resultDictList.replace(/,$/, '')
									}else{
										return  ''
									}
								}()+'</td>\n' +
								'    </tr>\n' +
								'    <tr>\n' +
								'      <td>子任务描述</td>\n' +
								'      <td>'+isShowNull(data.taskDesc)+'</td>\n' +
								'      <td>协助部门</td>\n' +
								'      <td>'+function () {
									if(data.assistCompanyDeptsName){
										return isShowNull(data.assistCompanyDeptsName.replace(/,$/, ''))
									}else{
										return  ''
									}
								}()+'</td>\n' +
								'    </tr>\n' +
								'<tr>' +
								'<td class="td_title">编制依据附件</td>' +
								'<td colspan="3">' +
								function () {
									if (!!data.attachments4 && data.attachments4.length > 0) {
										var str = '';

										data.attachments4.forEach(function (item) {
											var attachName = item.attachName;
											var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
											var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
											var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
											var attachmentUrl = item.attUrl;
											attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

											fileExtension = fileExtension.toLowerCase();

											str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
													'<div class="operationDiv" style="top: -50px;">' + function () {
														if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
															return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
														} else {
															return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
														}
													}() +
													'<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
													+ '</div>' +
													'</div>'
										});

										return str;
									} else {
										return '';
									}
								}() +
								'</td>' +
								'</tr>' +
								'  </tbody>\n' +
								'</table></div>',
					})
				})
			}

            //删除附件
            $(document).on('click', '.deImgs', function () {
                var _this = this;
                var attUrl = $(this).parents('.dech').attr('deUrl');
                layer.confirm('确定删除该附件吗？', function (index) {
                    $.ajax({
                        type: 'get',
                        url: '/delete?' + attUrl,
                        dataType: 'json',
                        success: function (res) {

                            if (res.flag == true) {
                                layer.msg('删除成功', {icon: 6, time: 1000});
                                $(_this).parent().remove();
                            } else {
                                layer.msg('删除失败', {icon: 2, time: 1000});
                            }
                        }
                    })
                });
            });

            //判断返回是否为空
            function empty(esName) {
                if (esName != undefined) {
                    return esName
                } else {
                    return ''
                }
            }


            function getPlanMonth(year, fn) {
                $.get('/planPeroidSetting/showAllSet', {periodYear: year}, function (res) {
                    var str = '<option value="">请选择</option>';
                    if (res.object.length > 0) {
                        res.object.forEach(function (item) {
                            str += '<option value="' + item.periodMonth + '">' + item.periodMonth + '</option>'
                        });
                    }
                    if (fn) {
                        fn(str);
                    }
                });
            }

            // 初始化页面操作权限
            function initAuthority() {
                // 是否设置页面权限
                if (authorityObject) {
                    // 检查查询权限
                    if (authorityObject['09']) {
                        $('.authority_search').show();
                    }
                }
            }

			/**
			 * 判断当前登录人在关键任务中的对应部门
			 * @returns {string}
			 */
			function getDeptId() {
				var deptId=''
				$.ajax({
					url: '/getLoginUser',
					type: 'GET',
					dataType: 'json',
					async: false,
					success: function(res){
						var userId = res.object.userId
						var data=$('#hiddenDeptId').data('data')
						if(data.dutyUser && data.dutyUser.replace(/,$/, '')==userId){
							deptId=data.mainCenterDept ? data.mainCenterDept.replace(/,$/,'') : ''
						}else if(data.mainAreaUser && data.mainAreaUser.replace(/,$/, '')==userId){
							deptId=data.mainAreaDept ? data.mainAreaDept.replace(/,$/,'') : ''
						}else if(data.mainProjectUser && data.mainProjectUser.replace(/,$/, '')==userId){
							deptId=data.mainProjectDept ? data.mainProjectDept.replace(/,$/,'') : ''
						}
					}
				})
				return deptId
			}

			//判断是否显示空
			function isShowNull(data) {
				if(data){
					return data
				}else{
					return ''
				}
			}

			//将毫秒数转为yyyy-MM-dd格式时间
			function format(t) {
				if(t) return new Date(t).Format("yyyy-MM-dd");
				else return ''
			}

			//附件上传 方法
			var timer=null;
			function fileuploadFn(formId,element) {
				$(formId).fileupload({
					dataType:'json',
					progressall: function (e, data) {
						var progress = parseInt(data.loaded / data.total * 100, 10);
						element.siblings('.progress').find('.bar').css(
								'width',
								progress + '%'
						);
						element.siblings('.barText').html(progress + '%');
						if(progress >= 100){  //判断滚动条到100%清除定时器
							timer=setTimeout(function () {
								element.siblings('.progress').find('.bar').css(
										'width',
										0 + '%'
								);
								element.siblings('.barText').html('');
							},2000);

						}
					},
					done: function (e, data) {
						if(data.result.obj != ''){
							var data = data.result.obj;
							var str = '';
							var str1 = '';
							for (var i = 0; i < data.length; i++) {
								var gs = data[i].attachName.split('.')[1];
								if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
									str += '';
									layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
										layer.closeAll();
									});
								}
								else{
									var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
									var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
									var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
									var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

									str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
								}
							}
							element.append(str);
						}else{
							layer.alert('添加附件大小不能为空!',{},function(){
								layer.closeAll();
							});
						}
					}
				});
			}

			//删除进展报表
			function delReport(me) {
				// console.log(me.attr('dailyId'))
				layer.confirm(
						"确认要删除吗，删除后不能恢复", { title: "删除确认" },function () {
							var loadIndex = layer.load();
							$.post('/ProjectDaily/delProjectDaily',{dailyId:me.attr('dailyId'),deptId:me.attr('deptId')},function (res) {
								if(res.flag){
									layer.close(loadIndex);
									layer.msg('删除成功！', {icon: 1});
									$('.layui_tr_active').trigger('click');
								}else{
									layer.close(loadIndex);
									layer.msg('删除失败！',{icon:0});
								}
							});
						})
			}

			//删除附件
			function delFile(me) {
				var attUrl = me.attr('deUrl');
				layer.confirm('确定删除该附件吗？', function (index) {
					$.ajax({
						type: 'get',
						url: '/delete?' + attUrl,
						dataType: 'json',
						success: function (res) {

							if (res.flag == true) {
								layer.msg('删除成功', {icon: 6, time: 1000});
								$('.layui_tr_active').trigger('click');
							} else {
								layer.msg('删除失败', {icon: 2, time: 1000});
							}
						}
					})
				});
			}

			// 附件查阅
            $(document).on('click', '.yulan', function () {
                var url = $(this).attr('data-url');
                pdurl($.UrlGetRequest('?' + url), url);
            });

            //判断是否显示空
            function isShowNull(data) {
                if (!!data) {
                    return data
                } else {
                    return ''
                }
            }

            /**
             * 将毫秒数转为yyyy-MM-dd格式时间
             * @param t (时间戳)
             * @returns {string}
             */
            function format(t) {
                if (t) {
                    return new Date(t).Format("yyyy-MM-dd");
                } else {
                    return '';
                }
            }

            //判断是否该为空
            function isUndefined(data) {
                if (data == 1) {
                    return '是'
                } else if (data == 0) {
                    return '否'
                } else {
                    return ''
                }
            }
		</script>
	</body>
</html>