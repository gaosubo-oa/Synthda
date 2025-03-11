<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/1/28
  Time: 9:44
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
		<title>部门考核绩效</title>

		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/js/base/base.js?20210330"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js?20210330"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js?20210330"></script>

		<style>
			html, body {
				width: 100%;
				height: 100%;
				background: #fff;
				overflow-x: hidden;
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
				position: relative;
				width: 100%;
				height: 100%;
			}

            .content {
	            padding: 0 20px;
            }

			/* region 查询表单样式 */
			.search_module {
				position: relative;
				border-bottom: 1px solid #ccc;
			    z-index: 2;
			}

			.query_item {
				float: left;
			}

			.search_form input, select {
				height: 35px;
			}

			.search_form .layui-form-label {
				width: 80px;
				height: 35px;
				padding: 0 10px;
				line-height: 35px;
				box-sizing: border-box;
			}

			.search_form .layui-form-item {
				height: 35px;
				margin: 0;
				clear: none;
			}

			.search_form .layui-input-block {
				margin-left: 80px;
			}

			.search_form .query_button_group {
				/*height: 100%;*/
				margin-top: 2px;
			}

			.search_form .query_btn {
				float: right;
				width: 55px;
				margin-right: 20px;
				margin-left: 0;
			}
			/* endregion */

			.td_img {
				width: 20px;
			}
			.divShow {
				position: relative;
			}

			.operationDiv {
				display: none;
				position: absolute;
				top: -40px;
				left: 5px;
				border-radius: 5px;
				background: #fff;
				box-shadow: 0 0 3px 1px rgba(0, 0, 0, .3);
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

			.layui-table-tool {
				z-index: 1;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<div class="search_module">
				<form class="layui-form clearfix search_form" lay-filter="searchForm">
					<div class="layui-row" style="padding: 5px 0;">
						<div class="layui-form-item query_item layui-col-xs3" style="width: 20%;">
							<label class="layui-form-label">姓名:</label>
							<div class="layui-input-block">
								<input type="text" id="userIds" name="userIds" placeholder="请选择用户" readonly autocomplete="off" class="layui-input" style="cursor: pointer;">
							</div>
						</div>
						<div class="layui-form-item query_item layui-col-xs3" style="width: 20%;">
							<label class="layui-form-label">部门:</label>
							<div class="layui-input-block">
								<div id="deptIdsSelect" class="xm-select-demo"></div>
							</div>
						</div>
						<div class="layui-form-item query_item layui-col-xs3" style="width: 20%;">
							<label class="layui-form-label">年度:</label>
							<div class="layui-input-block">
								<select name="year"></select>
							</div>
						</div>
						<div class="layui-form-item query_item layui-col-xs3" style="width: 20%;">
							<label class="layui-form-label">月度:</label>
							<div class="layui-input-block">
								<select name="month">
									<option value="">请选择</option>
								</select>
							</div>
						</div>
						<div class="query_button_group query_item layui-col-xs3" style="width: 20%;">
							<button type="button" id="searchBtn" class="layui-btn layui-btn-sm" style="margin-left: 15px;">查询</button>
							<button type="button" id="resetBtn" class="layui-btn layui-btn-sm">重置</button>
						</div>
					</div>
				</form>
			</div>
			<div class="content">
				<table id="tableObj" lay-filter="tableObj"></table>
			</div>
		</div>

		<script type="text/html" id="toolBar">
			<a class="layui-btn layui-btn-sm" lay-event="export">导出</a>
		</script>

		<script type="text/html" id="personBtn">
			<a class="layui-btn layui-btn-xs personDetail" lay-event="personDetail">个人明细</a>
		</script>

		<script type="text/html" id="checkboxTpl">
			<input type="checkbox" name="sex" value="{{d.userId}}" {{d.assessment ? 'checked' : ''}} disabled lay-skin="switch" lay-text="是|否" lay-filter="assessmentUser" />
		</script>

		<script>
			var nowDateObj = {
				year: new Date().getFullYear(),
				month: new Date().getMonth() + 1
			}
			var user_id = '';

			var userInfo = null;

            // 获取当前登录人信息
            $.get('/getLoginUser', function (res) {
                userInfo = res.object;
                init();
            });

            var dictionaryObj = {
				UNIT: {},
				CONTROL_LEVEL: {},
				RENWUJIHUA_TYPE: {},
				TG_TYPE: {},
				PLAN_SYCLE: {},
				PLAN_PHASE: {},
				targetData: {},
				CGCL_TYPE: {}
			}
			var dictionaryStr = 'UNIT,CONTROL_LEVEL,RENWUJIHUA_TYPE,TG_TYPE,PLAN_SYCLE,PLAN_PHASE,targetData,CGCL_TYPE';
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
			});

            function init() {
                layui.use(['form', 'xmSelect', 'table', 'eleTree'], function () {
                    var layuiForm = layui.form,
                        xmSelect = layui.xmSelect,
                        layuiTable = layui.table,
                        eleTree = layui.eleTree;

                    var tableObj = null;

                    var deptIdsSelect = null;

                    var deptIdsTree = null;
                    // 获取部门数据
                    $.get('/plcOrg/getTreeListByLoginer', function (res) {
                        deptIdsSelect = xmSelect.render({
                            el: '#deptIdsSelect',
                            content: '<div id="deptIdsTree" class="eleTree" lay-filter="deptIdsTree"></div>',
                            name: 'deptIds',
							toolbar: {
								show: true,
							},
                            prop: {
                                name: 'contractorName',
                                value: 'deptId'
                            },
                            on: function (data) {
                                // arr:  当前多选已选中的数据
                                var chooseArr = data.arr;

                                // isAdd, 此次操作是新增还是删除
                                if (!data.isAdd) {
                                    var arr = []
                                    chooseArr.forEach(function (item) {
                                        arr.push(item.deptId);
                                    });
                                    deptIdsTree.setChecked(arr, true);
                                }
                            }
                        });

                        deptIdsTree = eleTree.render({
                            elem: '#deptIdsTree',
                            data: res.object,
                            highlightCurrent: true,
                            showLine: true,
                            defaultExpandAll: true,
                            showCheckbox: true,
                            request: {
                                key: 'deptId',
                                name: 'contractorName',
                                children: "orgList"
                            }
                        });

                        // 树节点点击事件
                        eleTree.on("nodeChecked(deptIdsTree)", function (d) {
                            var checkedArr = deptIdsTree.getChecked();

                            var arr = []
                            checkedArr.forEach(function (item) {
                                var obj = {
                                    contractorName: item.contractorName,
                                    deptId: item.deptId
                                }
                                arr.push(obj);
                            });

                            deptIdsSelect.setValue(arr);
                        });

                        deptIdsSelect.setValue([{
                            contractorName: userInfo.deptName,
	                        deptId: userInfo.deptId
                        }]);
                        deptIdsTree.setChecked([userInfo.deptId], true);
                    });

                    // 获取计划期间年度列表
                    $.get('/planPeroidSetting/selectAllYear', function (res) {
                        var nowYearNo = '';
                        var allYear = '';
                        if (res.object.length > 0) {
                            res.object.forEach(function (item) {
                                allYear += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>';
                                if (!nowYearNo && (nowDateObj.year == item.periodYear)) {
                                    nowYearNo = item.periodYear;
                                }
                            });
                        }
                        $('.search_module [name="year"]').append(allYear);
                        $('.search_module [name="year"]').val(nowYearNo);

                        if (nowYearNo) {
                            getPlanMonth(nowYearNo, function (monthStr) {
	                            $('.search_form [name="month"]').html(monthStr);
                                $('.search_form [name="month"]').val(nowDateObj.month);
                                layuiForm.render('select');
                            });
                        }

                        tableInit({deptIds: userInfo.deptId, year: nowDateObj.year, month: nowDateObj.month});

                        layuiForm.render('select');
                    });

                    // 获取月度
                    layuiForm.on('select(planYear)', function (data) {
                        if (data.value) {
                            getPlanMonth(data.value, function (monthStr) {
                                $('.search_form [name="month"]').html(monthStr);
                                layuiForm.render('select');
                            });
                        } else {
                            $('.search_form [name="month"]').html('<option value="">请选择</option>');
                            layuiForm.render('select');
                        }
                    });

                    layuiForm.render();

                    $('#userIds').on('click', function () {
                        user_id = 'userIds';
                        $.popWindow('/common/selectUser');
                    });

					layuiTable.on('toolbar(tableObj)', function(obj){
						var datas = layuiTable.cache["tableObj"]

						if (datas.length == 0) {
							layer.msg('暂无数据', {icon: 0});
						}
                        switch (obj.event) {
                            case 'export':
                                var titleArr = ['序号', '姓名', '部门', '季度', '年', '月', '无需参与考核', '分数', '任务数量']

                                var dataArr = [];

                                datas.forEach(function (item, index) {
                                    var arr = []
                                    arr.push(index + 1);//序号
                                    arr.push(item.userName || ''); //姓名
                                    arr.push(item.deptName || ''); // 部门
                                    arr.push(item.season || ''); // 季度
                                    arr.push(item.periodYear ? item.periodYear + '年' : ''); //年
                                    arr.push(item.periodMonth ? item.periodMonth + '月' : ''); //月
                                    arr.push(item.assessment ? '是' : '否');//无需参与考核
                                    arr.push(item.comprehensiveScore);//分数
                                    arr.push(item.endMap.count || 0);//任务数量
                                    dataArr.push(arr);
                                });

                                layuiTable.exportFile(titleArr, dataArr, 'xls'); //默认导出 csv，也可以为：xls
                                break;
                        }
                        ;
					});

                    function tableInit(searchObj) {
                        searchObj = searchObj ? searchObj : {};
                        var loadIndex = layer.load();

                        tableObj = layuiTable.render({
                            elem: '#tableObj',
                            url: '/StatisticalReport/getPersonalScoreDetails',
                            page: false,
                            where: searchObj,
							toolbar: '#toolBar',
							defaultToolbar: [],
                            cols: [[
                                {type: 'numbers', title: '序号', align: 'center'},
                                {field: 'userName', title: '姓名', align: 'center'},
                                {field: 'deptName', title: '部门', align: 'center'},
                                {field: 'season', title: '季度', align: 'center'},
                                {
                                    field: 'periodYear', title: '年', align: 'center', templet: function (d) {
                                        return d.periodYear + '年'
                                    }
                                },
                                {
                                    field: 'periodMonth', title: '月', align: 'center', templet: function (d) {
                                        return d.periodMonth + '月'
                                    }
                                },
                                {field: 'lock', title: '无需参与考核', width: 120, templet: '#checkboxTpl', unresize: true},
                                {field: 'comprehensiveScore', title: '分数', align: 'center'},
                                {
                                    title: '任务数量', align: 'center', templet: function (data) {
                                        return '<div class="hoverDetail" style="position: relative">' + data.endMap.count +
                                            '<div class="hoverShow" style="position: relative;left: 100px;bottom: 20px;width: 130px; display: none; border-style: solid; white-space: nowrap; z-index: 9999999; transition: left 0.4s cubic-bezier(0.23, 1, 0.32, 1) 0s, top 0.4s cubic-bezier(0.23, 1, 0.32, 1) 0s; background-color: rgba(50, 50, 50, 0.7); border-width: 0px; border-color: rgb(51, 51, 51); border-radius: 4px; color: rgb(255, 255, 255); font: 14px / 21px "Microsoft YaHei"; padding: 5px; left: 410px; top: 34px;">' +
                                            function () {
                                                var map = data.endMap;
                                                var str = ''
                                                $.each(map, function (key, value) {
                                                    if (value && key != 'count') {
                                                        str += '<p>' + key + '：' + value + '条</p>'
                                                    }
                                                });
                                                return str
                                            }() +
                                            '</div>' +
                                            '</div>'
                                    }
                                },
                                {title: '明细', align: 'center', toolbar: '#personBtn'}
                            ]],
	                        height: 'full-80',
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                dataName: 'object'
                            },
                            done: function () {
                                layer.close(loadIndex);
                            }
                        });
                    }

                    // 查询
                    $('#searchBtn').on('click', function () {
                        var searchObj = {
                            deptIds: deptIdsSelect.getValue('valueStr'),
                            year: $('.search_module [name="year"]').val(),
                            month: $('.search_module [name="month"]').val(),
                            userIds: $('#userIds').attr('user_id') || ''
                        }

                        if (searchObj.userIds && !searchObj.deptIds) {
                            layer.msg('请选择部门！', {icon: 0, time: 1500});
                            return false;
                        }

                        tableInit(searchObj);
                    });

                    //查看关键任务和填报详情
                    $(document).on('click', '.target_detail', function () {
                        var tgId = $(this).attr('tgId')
                        $.ajax({
                            url: '/ProjectDaily/selectProjectDailyByItemId',
                            dataType: 'json',
                            type: 'get',
                            data: {tgId: tgId},
                            success: function (res) {
                                var data = res.data;
                                var targetData = res.object;

                                layer.open({
                                    type: 1,
                                    title: '关键任务和填报详情',
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

                                            dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;">关键任务详情</h3><table class="layui-table"><tbody>' +
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
                                                '<tr>' +
                                                '<td class="td_title">' + (targetData.deptOrProject == 0 ? '中心' : '') + '负责人</td>' +
                                                '<td colspan="1">' + isShowNull(targetData.dutyUserName).replace(/,$/, '') + '</td>' +
                                                '<td class="td_title">' + (targetData.deptOrProject == 0 ? '中心' : '') + '责任部门</td>' +
                                                '<td colspan="3">' + isShowNull(targetData.mainCenterDeptName).replace(/,$/, '') + '</td>' +
                                                '</tr>' +
                                                '<td class="td_title">实际开始时间</td>' +
                                                '<td>' +
                                                function () {
                                                    if (targetData.realStartDate) {
                                                        return format(targetData.realStartDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() +
                                                '</td>' +
                                                '<td class="td_title">实际结束时间</td>' +
                                                '<td>' +
                                                function () {
                                                    if (targetData.realEndDate) {
                                                        return format(targetData.realEndDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() +
                                                '</td>' +
                                                '<td class="td_title">实际工期</td>' +
                                                '<td>' + isShowNull(targetData.realContinuedDate) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">' + (targetData.deptOrProject == 0 ? '中心' : '') + '需提交的成果材料</td>' +
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
                                                '<td class="td_title">' + (targetData.deptOrProject == 0 ? '中心' : '') + '异常原因</td>' +
                                                '<td colspan="5">' + isShowNull(targetData.unusualRes) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">' + (targetData.deptOrProject == 0 ? '中心' : '') + '异常原因材料</td>' +
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
                                                '</tbody></table>';
                                        }

                                        if (!!data) {
                                            dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;margin-top: 10px;">关键任务填报信息</h3>';
                                            for (var i = 0; i < data.length; i++) {
                                                dayReport += '<table class="layui-table" style="margin-bottom: 5px">\n' +
                                                    '  <tbody>\n' +
                                                    '    <tr>\n' +
                                                    '      <td class="td_title">每日填报人</td>\n' +
                                                    '      <td>' + isShowNull(data[i].ctreateUserName) + '</td>\n' +
                                                    '      <td class="td_title">时间</td>\n' +
                                                    '      <td>' + isShowNull(data[i].ctreateTime) + '</td>\n' +
                                                    '    </tr>\n' +
                                                    '    <tr>\n' +
                                                    '      <td class="td_title">增加协作人</td>\n' +
                                                    '      <td>' + isShowNull(data[i].assistUserName) + '</td>\n' +
                                                    '      <td class="td_title">当日完成量</td>\n' +
                                                    '      <td>' + function () {
                                                        if (data[i].assistUserName || data[i].transfer) {
                                                            return '—'
                                                        } else {
                                                            return data[i].tadayProgress + '%'
                                                        }
                                                    }() + '</td>\n' +
                                                    '    </tr>\n' +
                                                    '    <tr>\n' +
                                                    '      <td class="td_title">转办</td>\n' +
                                                    '      <td colspan="3">' + isShowNull(data[i].transfer) + '</td>\n' +
                                                    '    </tr>\n' +
                                                    '    <tr>\n' +
                                                    '      <td class="td_title">进展日志</td>\n' +
                                                    '      <td colspan="3">' + isShowNull(data[i].tadayDesc) + '</td>\n' +
                                                    '    </tr>\n' +
                                                    '  </tbody>\n' +
                                                    '</table>';
                                            }
                                        }

                                        $('#target_detail').html(dayReport);
                                    }
                                })
                            }
                        })
                    });
                    //查看子任务和填报详情
                    $(document).on('click', '.task_detail', function () {
                        var planItemId = $(this).attr('planItemId')
                        $.ajax({
                            url: '/ProjectDaily/selectProjectDailyByItemId',
                            dataType: 'json',
                            type: 'get',
                            data: {planItemId: planItemId},
                            success: function (res) {
                                var taskData = res.object;
                                var data = res.data

                                layer.open({
                                    type: 1,
                                    title: '子任务和填报详情',
                                    area: ['70%', '90%'],
                                    maxmin: true,
                                    min: function () {
                                        $('.layui-layer-shade').hide()
                                    },
                                    content: '<div id="task_detail" style="margin:10px"></div>',
                                    success: function () {
                                        var dayReport = '';

                                        if (!!taskData) {
                                            dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;">子任务详情</h3><table class="layui-table">\n' +
                                                '  <tbody>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">编号</td>\n' +
                                                '      <td colspan="1">' + isShowNull(taskData.taskNo) + '</td>\n' +
                                                '      <td class="td_title">上级子任务名称</td>\n' +
                                                '      <td colspan="3" class="topItemDetail"></td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">子任务名称</td>\n' +
                                                '      <td colspan="1">' + isShowNull(taskData.taskName) + '</td>\n' +
                                                '      <td class="td_title">关联关键任务</td>\n' +
                                                '      <td colspan="3">' + function () {
                                                    var tgIds = ''
                                                    if (taskData.tgIds) {
                                                        taskData.tgIds.forEach(function (item) {
                                                            tgIds += item.tgName + ','
                                                        })
                                                        return tgIds.replace(/,$/, '')
                                                    } else {
                                                        return '';
                                                    }
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">周期类型</td>\n' +
                                                '      <td colspan="1">' + isShowNull(dictionaryObj['PLAN_SYCLE']['object'][taskData.planSycle]) + '</td>\n' +
                                                '      <td class="td_title">子任务类型</td>\n' +
                                                '      <td colspan="3">' + isShowNull(dictionaryObj['RENWUJIHUA_TYPE']['object'][taskData.taskType]) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">负责人</td>\n' +
                                                '      <td colspan="1">' + isShowNull(taskData.dutyUserName.replace(/,$/, '')) + '</td>\n' +
                                                '      <td class="td_title">所属部门</td>\n' +
                                                '      <td colspan="3">' + isShowNull(taskData.mainCenterDeptName.replace(/,$/, '')) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">计划开始时间</td>\n' +
                                                '      <td>' + function () {
                                                    if (taskData.planStartDate) {
                                                        return format(taskData.planStartDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() + '</td>\n' +
                                                '      <td class="td_title">计划结束时间</td>\n' +
                                                '      <td>' + function () {
                                                    if (taskData.planEndDate) {
                                                        return format(taskData.planEndDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() + '</td>\n' +
                                                '      <td class="td_title">计划工期</td>\n' +
                                                '      <td>' + isShowNull(taskData.planContinuedDate) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">实际开始时间</td>\n' +
                                                '      <td>' + function () {
                                                    if (taskData.realStartDate) {
                                                        return format(taskData.realStartDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() + '</td>\n' +
                                                '      <td class="td_title">实际结束时间</td>\n' +
                                                '      <td>' + function () {
                                                    if (taskData.realEndDate) {
                                                        return format(taskData.realEndDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() + '</td>\n' +
                                                '      <td class="td_title">实际工期</td>\n' +
                                                '      <td>' + isShowNull(taskData.realContinuedDate) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">前置子任务</td>\n' +
                                                '      <td colspan="1">' + function () {
                                                    var preTasks = ''
                                                    if (taskData.preTasks) {
                                                        taskData.preTasks.forEach(function (item) {
                                                            preTasks += item.workItemName + ','
                                                        })
                                                        return preTasks.replace(/,$/, '')
                                                    } else {
                                                        return ''
                                                    }
                                                }() + '</td>\n' +
                                                '      <td class="td_title">完成标准</td>\n' +
                                                '      <td colspan="3">' + isShowNull(taskData.resultStandard) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">子任务描述</td>\n' +
                                                '      <td colspan="1">' + isShowNull(taskData.taskDesc) + '</td>\n' +
                                                '      <td class="td_title">协助部门</td>\n' +
                                                '      <td colspan="3">' + function () {
                                                    if (taskData.assistCompanyDeptsName) {
                                                        return isShowNull(taskData.assistCompanyDeptsName.replace(/,$/, ''))
                                                    } else {
                                                        return ''
                                                    }
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '<tr>' +
                                                '<td class="td_title">成果标准模板</td>' +
                                                '<td colspan="5">' +
                                                function () {
                                                    var resultDictName = '';
                                                    if (!!taskData.resultDict) {
                                                        var resultDictList = taskData.resultDict.split(',');

                                                        resultDictList.forEach(function (item) {
                                                            resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
                                                        });
                                                    }

                                                    return resultDictName.replace(/,$/, '');
                                                }() +
                                                '</td>' +
                                                '</tr>' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">需提交的成果材料</td>\n' +
                                                '      <td colspan="5">' + function () {
                                                    if (!!taskData.attachments2 && taskData.attachments2.length > 0) {
                                                        var str = '';

                                                        taskData.attachments2.forEach(function (item) {
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
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">异常原因</td>\n' +
                                                '      <td colspan="5">' + isShowNull(taskData.unusualRes) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">异常原因材料</td>\n' +
                                                '      <td colspan="5">' + function () {
                                                    if (!!taskData.attachments3 && taskData.attachments3.length > 0) {
                                                        var str = '';

                                                        taskData.attachments3.forEach(function (item) {
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
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">难度点</td>\n' +
                                                '      <td colspan="1">' + isShowNull(taskData.difficultPoint) + '</td>\n' +
                                                '      <td class="td_title">风险点</td>\n' +
                                                '      <td colspan="3">' + isShowNull(taskData.riskPoint) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">编制依据附件</td>\n' +
                                                '      <td colspan="5">' + function () {
                                                    if (!!taskData.attachments4 && taskData.attachments4.length > 0) {
                                                        var str = '';

                                                        taskData.attachments4.forEach(function (item) {
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
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '    </tr>\n' +
                                                '  </tbody>\n' +
                                                '</table>';

                                            if (taskData.plcAssistList.length > 0) {
                                                dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;margin-top: 10px;">协助子任务信息</h3>';
                                                taskData.plcAssistList.forEach(function (obj) {
                                                    dayReport += '<table class="layui-table" style="margin-bottom: 5px;">\n' +
                                                        '  <tbody>\n' +
                                                        '    <tr>\n' +
                                                        '      <td class="td_title">协助人</td>\n' +
                                                        '      <td colspan="1">' + isShowNull(obj.assistUserName) + '</td>\n' +
                                                        '      <td class="td_title">协助部门</td>\n' +
                                                        '      <td colspan="3">' + isShowNull(obj.assistDeptName) + '</td>\n' +
                                                        '    </tr>\n' +
                                                        '    <tr>\n' +
                                                        '      <td class="td_title">完成状态</td>\n' +
                                                        '      <td colspan="1">' + isShowNull(obj.taskStatus) + '</td>\n' +
                                                        '      <td class="td_title">任务进度</td>\n' +
                                                        '      <td colspan="3">' + isShowNull(obj.taskPrecess) + '</td>\n' +
                                                        '    </tr>\n' +
                                                        '    <tr>\n' +
                                                        '      <td class="td_title">计划开始时间</td>\n' +
                                                        '      <td colspan="1">' + format(obj.planStartDate) + '</td>\n' +
                                                        '<td class="td_title">计划完成时间</td>\n' +
                                                        '      <td colspan="3">' + format(obj.planEndDate) + '</td>\n' +
                                                        '    </tr>\n' +
                                                        '    <tr>\n' +
                                                        '      <td class="td_title">实际完成时间</td>\n' +
                                                        '      <td colspan="3">' + format(obj.realEndDate) + '</td>\n' +
                                                        '    </tr>\n' +
                                                        '    <tr>\n' +
                                                        '      <td class="td_title">最终成果</td>\n' +
                                                        '      <td colspan="5">' + function () {
                                                            if (!!obj.attment1 && obj.attment1.length > 0) {
                                                                var str = '';

                                                                obj.attment1.forEach(function (item) {
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
                                                        }() + '</td>\n' +
                                                        '    </tr>\n' +
                                                        '    <tr>\n' +
                                                        '      <td class="td_title">异常支撑材料</td>\n' +
                                                        '      <td colspan="3">' + isShowNull(obj.unusualStuff) + '</td>\n' +
                                                        '    </tr>\n' +
                                                        '    <tr>\n' +
                                                        '      <td class="td_title">最终成果</td>\n' +
                                                        '      <td colspan="5">' + function () {
                                                            if (!!obj.attachments2 && obj.attachments2.length > 0) {
                                                                var str = '';

                                                                obj.attachments2.forEach(function (item) {
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
                                                        }() + '</td>\n' +
                                                        '    </tr>\n' +
                                                        '  </tbody>\n' +
                                                        '</table>'
                                                })
                                            }
                                        }

                                        dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;margin-top: 10px;">子任务填报信息</h3>';
                                        for (var i = 0; i < data.length; i++) {
                                            dayReport += '<table class="layui-table" style="margin-bottom: 5px;">\n' +
                                                '  <tbody>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">每日填报人</td>\n' +
                                                '      <td>' + isShowNull(data[i].ctreateUserName) + '</td>\n' +
                                                '      <td class="td_title">时间</td>\n' +
                                                '      <td>' + isShowNull(data[i].ctreateTime) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">增加协作人</td>\n' +
                                                '      <td>' + isShowNull(data[i].assistUserName) + '</td>\n' +
                                                '      <td class="td_title">当日完成量</td>\n' +
                                                '      <td>' + function () {
                                                    if (data[i].assistUserName || data[i].transfer) {
                                                        return '—'
                                                    } else {
                                                        return data[i].tadayProgress + '%'
                                                    }
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">转办</td>\n' +
                                                '      <td colspan="3">' + isShowNull(data[i].transfer) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">进展日志</td>\n' +
                                                '      <td colspan="3">' + isShowNull(data[i].tadayDesc) + '</td>\n' +
                                                '    </tr>\n' +
                                                '  </tbody>\n' +
                                                '</table>'
                                        }
                                        $('#task_detail').append(dayReport)
                                    }
                                })
                            }
                        })
                    });

                    //悬浮显示详情
                    $(document).on('mouseover', '.hoverDetail', function () {
                        $(this).find('.hoverShow').show();
                        $('.layui-table-cell, .layui-table-tool-panel li').css('overflow', 'inherit');
                        $(this).css('height', '27.5px');
                        var height = $(this).find('.hoverShow').height() + 'px';
                        $('#timeDetail').next().find('.layui-table tr').find('.hoverShow').css('bottom', height);
                        $('#departmentTime').next().find('.layui-table tr').find('.hoverShow').css('bottom', height);
                    });
                    $(document).on('mouseout', '.hoverDetail', function () {
                        $(this).find('.hoverShow').hide();
                    });

                    layuiTable.on('tool(tableObj)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        console.log(data);
                        if (layEvent === 'personDetail') {//时间下-----个人明细
                            layer.open({
                                type: 1,
                                title: '明细',
                                area: ['100%', '100%'],
                                content: '<div style="padding: 8px">' +
                                    '<ul class="icon_box clearfix" style="margin-top: 10px">\n' +
                                    '<li class="icon_item">\n' +
                                    '状态图标：\n' +
                                    '</li>\n' +
                                    '<li class="icon_item">\n' +
                                    '<img class="icon_img" src="/img/planCheck/planProgressReport/not_started.png">\n' +
                                    '<span class="icon_tip">未开始</span>\n' +
                                    '</li>\n' +
                                    '<li class="icon_item">\n' +
                                    '<img class="icon_img" src="/img/planCheck/planProgressReport/underway.png">\n' +
                                    '<span class="icon_tip">进行中</span>\n' +
                                    '</li>\n' +
                                    '<li class="icon_item">\n' +
                                    '<img class="icon_img" src="/img/planCheck/planProgressReport/delay_underway.png">\n' +
                                    '<span class="icon_tip">将到期</span>\n' +
                                    '</li>\n' +
                                    '<li class="icon_item">\n' +
                                    '<img class="icon_img" src="/img/planCheck/planProgressReport/out_underway.png">\n' +
                                    '<span class="icon_tip">已延期</span>\n' +
                                    '</li>\n' +
                                    '<li class="icon_item">\n' +
                                    '<img class="icon_img" src="/img/planCheck/planProgressReport/complete.png">\n' +
                                    '<span class="icon_tip">完成</span>\n' +
                                    '</li>\n' +
                                    '<li class="icon_item">\n' +
                                    '<img class="icon_img" src="/img/planCheck/planProgressReport/delay_complete.png">\n' +
                                    '<span class="icon_tip">延期完成</span>\n' +
                                    '</li>\n' +
                                    '<li class="icon_item">\n' +
                                    '<img class="icon_img" src="/img/planCheck/planProgressReport/result_default.png">\n' +
                                    '<span class="icon_tip">成果不符</span>\n' +
                                    '</li>\n' +
                                    '<li class="icon_item">\n' +
                                    '<img class="icon_img" src="/img/planCheck/planProgressReport/closed.png">\n' +
                                    '<span class="icon_tip">关闭</span>\n' +
                                    '</li>\n' +
                                    '<li class="icon_item">\n' +
                                    '<img class="icon_img" src="/img/planCheck/planProgressReport/suspend.png">\n' +
                                    '<span class="icon_tip">暂停</span>\n' +
                                    '</li>\n' +
                                    '</ul>' +
                                    '<table id="personDetail" lay-filter="departmentTime"></table></div>',
                                success: function () {
                                    $.get('/StatisticalReport/personalAssessmentInfo', {
                                        adMonth: data.periodMonth,
                                        userId: data.userId,
                                        year: data.periodYear,
                                        deptId: data.deptId
                                    }, function (res) {
                                        if (res.flag) {
                                            var dataObj = initDetailListData(res.object.item, res.object.target);

                                            layuiTable.render({
                                                elem: '#personDetail',
                                                data: dataObj.array,
                                                cols: [[
                                                    {
                                                        field: 'taskStatus',
                                                        title: '子任务/关键任务状态',
                                                        align: 'left',
                                                        minWidth: 70,
                                                        templet: function (d) {
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
                                                            } else if (d.taskStatus == '9') {
                                                                // '成果不符';
                                                                return '<img class="td_img" src="/img/planCheck/planProgressReport/result_default.png"/>';
                                                            } else if (d.taskStatus == '8') {
                                                                // '关闭';
                                                                return '<img class="td_img" src="/img/planCheck/planProgressReport/closed.png"/>';
                                                            } else {
                                                                return '';
                                                            }
                                                        }
                                                    },
                                                    {
                                                        field: 'tgName', title: '关键任务/子任务名称', align: 'left', minWidth: 300, templet: function (d) {
                                                            if (d.tgName) {
                                                                return '<span tgId="' + d.tgId + '" class="target_detail" style="color: blue;cursor: pointer">【关键任务】' + d.tgName + '</span>'
                                                            } else if (d.taskName) {
                                                                return '<span planItemId="' + d.planItemId + '" class="task_detail" style="color: blue;cursor: pointer">【子任务】' + d.taskName + '</span>'
                                                            } else {
                                                                return ''
                                                            }
                                                        }
                                                    },
                                                    {
                                                        field: 'taskType',
                                                        title: '关键任务/子任务类型',
                                                        align: 'left',
                                                        minWidth: 60,
                                                        templet: function (d) {
                                                            if (d.tgType) {
                                                                return dictionaryObj['TG_TYPE']['object'][d.tgType] || ''
                                                            } else {
                                                                return dictionaryObj['RENWUJIHUA_TYPE']['object'][d.taskType] || ''
                                                            }
                                                        }
                                                    },
                                                    {
                                                        field: 'hardDegree', title: '难度系数', minWidth: 40, align: 'left', templet: function (d) {
                                                            return d.hardDegree || '';
                                                        }
                                                    },
                                                    {
                                                        field: 'taskPrecess', title: '完成度', minWidth: 40, align: 'left', templet: function (d) {
                                                            return d.taskPrecess || '';
                                                        }
                                                    },
                                                    {
                                                        field: 'qualityScore', minWidth: 70, title: '质量得分', templet: function (d) {
                                                            return d.qualityScore ? (d.qualityScore + '分') : '';
                                                        }
                                                    },
                                                    {
                                                        field: 'minusPoints', minWidth: 70, title: '扣分项', templet: function (d) {
                                                            return d.minusPoints ? (d.minusPoints + '分') : '';
                                                        }
                                                    },
                                                    {
                                                        field: 'endScore', minWidth: 70, title: '单项得分', templet: function (d) {
                                                            if (d.status == 0) {
                                                                return '未考核'
                                                            } else {
                                                                return d.endScore ? (d.endScore + '分') : '0分';
                                                            }
                                                        }
                                                    },
                                                    {
                                                        field: 'planStartDate', title: '计划开始时间', minWidth: 100, templet: function (d) {
                                                            return format(d.planStartDate)
                                                        }
                                                    },
                                                    {
                                                        field: 'planEndDate', title: '计划结束时间', minWidth: 100, templet: function (d) {
                                                            return format(d.planEndDate)
                                                        }
                                                    },
                                                    {field: 'planContinuedDate', minWidth: 70, title: '计划工期'},
                                                    {
                                                        field: 'resultStandard', title: '完成标准', minWidth: 300,
                                                    },
                                                ]],
                                                limit: 10000
                                            });
                                        }
                                    });
                                }
                            });
                        }
                    });
                });
            }

            /***
             * 获取计划期间月度
             * @param planYear (月度对应年份)
             * @param cb (回调函数)
             */
            function getPlanMonth(planYear, fn) {
                $.get('/planPeroidSetting/showAllSet', {periodYear: planYear}, function (res) {
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

            /**
			 * 处理项目详情数据
			 * @param taskArr 子任务数据
			 * @param targetArr 关键任务数据
			 * @returns {{array: any[], monthEndScore: number}}
			 */
			function initDetailListData(taskArr, targetArr) {
				var array = new Array();
				var monthEndScore = 0;
				if (taskArr && taskArr.length > 0) {
					taskArr.forEach(function (task) {
						task.name = task.taskName;
						task.no = task.taskNo;
						task.taskOrTarget = 1;
						var endScore = parseFloat(task.endScore);
						if (isNaN(endScore)) {
							endScore = 0;
						}
						monthEndScore += (endScore * 10000);
						array.push(task);
					});
				}
				if (targetArr && targetArr.length > 0) {
					targetArr.forEach(function (target) {
						target.name = target.tgName;
						target.no = target.tgNo;
						target.taskOrTarget = 2;
						var endScore = parseFloat(target.endScore);
						if (isNaN(endScore)) {
							endScore = 0;
						}
						monthEndScore += (endScore * 10000);
						array.push(target);
					});
				}
				return {array: array, monthEndScore: monthEndScore / 10000};
			}

			//将毫秒数转为yyyy-MM-dd格式时间
			function format(t) {
				if (t) {
					return new Date(t).Format("yyyy-MM-dd");
				} else {
					return '';
				}
			}

			//判断是否显示空
			function isShowNull(data) {
				if (!!data) {
					return data
				} else {
					return ''
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

			//判断返回是否为空
			function empty(esName) {
				if (esName != undefined) {
					return esName
				} else {
					return ''
				}
			}

		</script>
	</body>
</html>
