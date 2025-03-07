<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/2/20
  Time: 15:52
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
		<title>职责详情</title>

		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" href="/css/officialDocument/officialDocument.css">

		<link type="text/css" rel="stylesheet" href="/lib/pagination/style/pagination.css">
		<link rel="stylesheet" href="/css/base/base.css?20201106.1">
		<link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>

		<script src="/js/common/language.js"></script>

		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
		<script src="/js/jquery/jquery.cookie.js"></script>
		<script type="text/javascript" src="/js/base/tablePage.js"></script>
		<script src="/js/base/base.js"></script>
		<script type="text/javascript" charset="utf-8" src="/lib/pagination/js/jquery.pagination.min.js"></script>
		<script type="text/javascript" src="/js/planbudget/echarts.min.js"></script>

		<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
		<style>

            table tr {
                border-width: 1px;
                border-style: solid;
                border-color: rgb(204, 204, 204);
                border-image: initial;
            }

            table tr th {
                font-size: 13pt;
                color: #fff;
                text-align: center;
                padding: 6px;
	            border: 1px solid #000;
            }

            table td {
                font-size: 11pt;
                padding: 6px;
                height: 30px;
                line-height: 30px;
                text-align: center;
                word-break: keep-all;
                white-space: nowrap;
                text-overflow: ellipsis;
	            border: 1px solid;
                overflow: hidden;
            }

            table tr:nth-child(2n) {
                background-color: rgb(255, 255, 255);
            }

            table tr:nth-child(2n+1) {
                background-color: #F6F7F9;
            }

            .level {
	            cursor: pointer;
            }

            .label_item {
				padding: 8px 0;
	            font-size: 14px;
				text-align: center;
			}

			.label_ttile {
				display: inline-block;
				width: 100px;
				text-align: left;
			}

			.label_con {
				display: inline-block;
				width: 50%;
				min-width: 300px;
				border-bottom: 1px solid #eee;
				text-align: left;
			}

            .button_box {
                padding-bottom: 5px;
                border-bottom: 1px solid #eee;
            }
		</style>
	</head>
	<body>
		<div class="clearfix" style="margin-bottom: 10px;">
			<label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;">
	            <span class="fl" style="margin-top: 5px;">部门名称：</span>
	            <label class="fl">
		            <select name="mergerDeptName" id="mergerDeptName"></select>
	            </label>
	        </label>
			<label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;">
	            <span class="fl" style="margin-top: 5px;">职责类别：</span>
	            <label class="fl">
		            <select name="dutyJobType" id="dutyJobType"></select>
	            </label>
	        </label>
			<label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;">
	            <span class="fl" style="margin-top: 5px;">职责类型：</span>
	            <label class="fl">
		            <select name="dutyType" id="dutyType">
			            <option value="">请选择</option>
			            <option value="01">公司总部</option>
			            <option value="02">区域总部</option>
			            <option value="03">总承包部</option>
		            </select>
	            </label>
	            <button type="button" class="Query fl QuerySearch"><fmt:message code="global.lang.query"/></button>
	        </label>
		</div>

		<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
			<ul class="layui-tab-title">
				<li class="layui-this" queryType="1">整体详情</li>
				<li queryType="0">单部门详情</li>
			</ul>
			<div class="layui-tab-content">
				<div class="layui-tab-item layui-show">
					<div class="content">
						<table>
							<thead>
							<tr>
								<th colspan="5" style="background-color: #D2334A;">总部部门职责</th>
								<th colspan="3" style="background-color: #002060;">分公司部门职责</th>
								<th colspan="3" style="background-color: #2F5597;">项目部门职责</th>
							</tr>
							<tr style="background-color: #7F7F7F;">
								<th>部门名称</th>
								<th>职责类别</th>
								<th>一级职责</th>
								<th>二级职责</th>
								<th>三级职责</th>
								<th>部门名称</th>
								<th>四级职责</th>
								<th>五级职责</th>
								<th>部门名称</th>
								<th>六级职责</th>
								<th>七级职责</th>
							</tr>
							</thead>
							<tbody class="t_body">

							</tbody>
						</table>
					</div>
				</div>
				<div class="layui-tab-item">
					<div id="myChart" style="height: 600px;margin: 0 auto;"></div>
				</div>
			</div>
		</div>

		<script>

			window.onresize = function () {
                resizeTable();
                myChart.resize();
            };

            resizeTable();

            function resizeTable () {
                var windowWidth = $(window).width();

                $('#myChart').width((windowWidth - 40));
            }

			var level1 = [];
			var level2 = [];
			var level3 = [];
			var level4 = [];
			var level5 = [];
			var level6 = [];
			var level7 = [];

			var deptOne = '';
			var deptTwo = '';
			var deptThree = '';

			var dutyIds = [];

			var treeObj = {};

            $('.QuerySearch').on('click', function () {
                var mergerDeptName = $('#mergerDeptName').val();
                var dutyJobType = $('#dutyJobType').val();
                var dutyType = $('#dutyType').val();
                var queryType = $('.layui-this').attr('queryType') || 1;
                if (queryType == 1) {
                    initData(mergerDeptName, dutyJobType, 1, dutyType);
                } else {
                    loadTable(mergerDeptName, dutyJobType, 0, dutyType)
                }
            });

            $.get('/Dictonary/selectDictionaryByDictNos?dictNos=TG_TYPE_PARENT,TG_TYPE', function (res) {
                var str1 = '<option value="">请选择</option>';
                res.object.TG_TYPE_PARENT.forEach(function (item) {
                    str1 += '<option value="' + item.dictNo + '">' + item.dictName + '</option>';
                });
				$('#mergerDeptName').html(str1);

                var str2 = '<option value="">请选择</option>';
                res.object.TG_TYPE.forEach(function (item) {
                    str1 += '<option value="' + item.dictNo + '">' + item.dictName + '</option>';
                });
                $('#dutyJobType').html(str1);
            });

			var dutyType = {}
            $.get('/code/getCode?parentNo=INSTITUTION_SORT_LEVEL', function (res) {
                res.obj.forEach(function (item) {
                    dutyType[item.codeNo] = item.codeName;
                });

                initData('', '', 1, '');
            });

            function initData(mergerDeptName, dutyJobType, queryType, dutyType) {
                var loadIndex = layer.load();
                level1 = [];
                level2 = [];
                level3 = [];
                level4 = [];
                level5 = [];
                level6 = [];
                level7 = [];

                deptOne = '';
                deptTwo = '';
                deptThree = '';

                dutyIds = [];
                $.get('/userJobDuty/shouJobDuty', {
                    mergerDeptName: mergerDeptName,
                    dutyJobType: dutyJobType,
                    dutyGrade: '',
                    queryType: queryType,
                    dutyType: dutyType
                }, function (res) {
                    if (res.flag) {
                        getList(res.data);

                        var data = getTableData();

                        var str = '';

                        data.forEach(function (item, index) {
                            if (index == 0) {
                                str += '<tr><td style="color:#fff; font-size: 13pt; background-color: #7F7F7F;border: 1px solid #000;" rowspan="' + data.length + '">' + deptOne + '</td>';
                            } else {
                                str += '<tr><td style="display: none;">' + deptOne + '</td>';
                            }

                            str += '<td dutyId="' + item.level + '">' + item.level + '</td><td dutyId="' + item.level1.id + '"><span class="level" dutyId="' + item.level1.dutyId + '">' + item.level1.dutyName + '</span></td>';

                            if (item.level2) {
                                str += '<td dutyId="' + item.level2.id + '"><span class="level" dutyId="' + item.level2.dutyId + '">' + item.level2.dutyName + '</span></td>';
                            } else {
                                str += '<td></td>';
                            }

                            if (item.level3) {
                                str += '<td dutyId="' + item.level3.id + '"><span class="level" dutyId="' + item.level3.dutyId + '">' + item.level3.dutyName + '</span></td>';
                            } else {
                                str += '<td></td>';
                            }

                            if (index == 0) {
                                str += '<td style="color:#fff; font-size: 13pt; background-color: #7F7F7F;border: 1px solid #000;" rowspan="' + data.length + '">' + deptTwo + '</td>';
                            } else {
                                str += '<td style="display: none;">' + deptTwo + '</td>';
                            }

                            if (item.level4) {
                                str += '<td dutyId="' + item.level4.id + '"><span class="level" dutyId="' + item.level4.dutyId + '">' + item.level4.dutyName + '</span></td>';
                            } else {
                                str += '<td></td>';
                            }

                            if (item.level5) {
                                str += '<td dutyId="' + item.level5.id + '"><span class="level" dutyId="' + item.level5.dutyId + '">' + item.level5.dutyName + '</span></td>';
                            } else {
                                str += '<td></td>';
                            }

                            if (index == 0) {
                                str += '<td style="color:#fff; font-size: 13pt; background-color: #7F7F7F;border: 1px solid #000;" rowspan="' + data.length + '">' + deptThree + '</td>';
                            } else {
                                str += '<td style="display: none;">' + deptThree + '</td>';
                            }

                            if (item.level6) {
                                str += '<td dutyId="' + item.level6.id + '"><span class="level" dutyId="' + item.level6.dutyId + '">' + item.level6.dutyName + '</span></td>';
                            } else {
                                str += '<td></td>';
                            }

                            if (item.level7) {
                                str += '<td dutyId="' + item.level7.id + '"><span class="level" dutyId="' + item.level7.dutyId + '">' + item.level7.dutyName + '</span></td>';
                            } else {
                                str += '<td></td>';
                            }
                            str += '</tr>';
                        });

                        $('.t_body').html(str);

                        dutyIds.forEach(function (item) {
                            var $tds = $('.t_body [dutyId="' + item + '"]');
                            $tds.hide();
                            $tds.eq(0).attr('rowspan', $tds.length).show();
                        });
                    }
                    layer.close(loadIndex);
                });
            }

			function getList(treeData, dutyParentName) {
			    if (treeData && treeData.length > 0) {
			        treeData.forEach(function(item) {
			            var obj = {
			                dutyGrade: item.dutyGrade,
                            dutyId: item.dutyId,
				            dutyJobType: item.dutyJobType,
				            dutyName: item.dutyName,
				            dutyParent: item.dutyParent,
				            dutyParentName: dutyParentName || '顶级职责',
				            dutyParents: item.dutyParents || '',
				            dutyType: item.dutyType,
				            isFinalNode: item.isFinalNode,
				            jobIds: item.jobIds,
				            mergerDeptName: item.mergerDeptName,
				            dutyDesc: item.dutyDesc
			            }

			            treeObj[item.dutyId] = obj;

                        if (item.dutyGrade == 1) {
                            level1.push(obj);
                        } else if (item.dutyGrade == 2) {
                            level2.push(obj);
                        } else if (item.dutyGrade == 3) {
                            level3.push(obj);
                        } else if (item.dutyGrade == 4) {
                            level4.push(obj);
                        } else if (item.dutyGrade == 5) {
                            level5.push(obj);
                        } else if (item.dutyGrade == 6) {
                            level6.push(obj);
                        } else if (item.dutyGrade == 7) {
                            level7.push(obj);
                        }

			            if (item.child && item.child.length > 0) {
			                getList(item.child, item.dutyName);
			            }
			        });
			    }
			}

            function getTableData() {
			    var arr = [];

			    var newArr = [];

                level1.forEach(function (level1) {
                    if (newArr.indexOf(level1.dutyJobType) == -1) {
                        newArr.push(level1.dutyJobType);
                        dutyIds.push(level1.dutyJobType);
                    }
                });

                newArr.forEach(function (item) {
                    var newlevel1 = [];

                    level1.forEach(function (level1) {
                        if (item == level1.dutyJobType) {
                            newlevel1.push(level1);
                            dutyIds.push(level1.dutyParent + '_' + level1.dutyId);
                        }
                    });

                    newlevel1.forEach(function (level1) {
                        deptOne = level1.mergerDeptName;
                        var newlevel2 = [];
                        level2.forEach(function (level2) {
                            if (level1.dutyId == level2.dutyParent) {
                                newlevel2.push(level2);

                                dutyIds.push(level2.dutyParent + '_' + level2.dutyId);
                            }
                        });

                        if (newlevel2.length > 0) {
                            newlevel2.forEach(function (level2) {
                                var newlevel3 = [];
                                level3.forEach(function (level3) {
                                    if (level2.dutyId == level3.dutyParent) {
                                        newlevel3.push(level3);

                                        dutyIds.push(level3.dutyParent + '_' + level3.dutyId);
                                    }
                                });

                                if (newlevel3.length > 0) {
                                    var flag = false;
                                    var level3parents = '';
                                    newlevel3.forEach(function (level3, index3) {
                                        var newlevel4 = [];
                                        level4.forEach(function (level4) {
                                            deptTwo = level4.mergerDeptName;
                                            var dutyParents = ',' + level4.dutyParents;
                                            if (dutyParents.indexOf(',' + level3.dutyId + ',') > -1) {
                                                newlevel4.push(level4);
                                                if (!flag) {
                                                    level3parents = dutyParents;
                                                }
                                                dutyIds.push(level3.dutyParent + '_' + level3.dutyId + '_' + level4.dutyId);
                                            }
                                        });

                                        if (newlevel4.length > 0 && !flag) {
                                            newlevel4.forEach(function (level4) {
                                                var newlevel5 = [];
                                                level5.forEach(function (level5) {
                                                    if (level4.dutyId == level5.dutyParent) {
                                                        newlevel5.push(level5);

                                                        dutyIds.push(level3.dutyParent + '_' + level3.dutyId + '_' + level5.dutyId);
                                                    }
                                                });

                                                if (newlevel5.length > 0) {
                                                    var flag = false;
                                                    var level5parents = '';
                                                    newlevel5.forEach(function (level5) {
                                                        var newlevel6 = [];

                                                        level6.forEach(function (level6) {
                                                            deptThree = level6.mergerDeptName;
                                                            var dutyParents = ',' + level6.dutyParents
                                                            if (dutyParents.indexOf(',' + level5.dutyId + ',') > -1) {
                                                                newlevel6.push(level6);
                                                                if (!flag) {
                                                                    level5parents = dutyParents;
                                                                }
                                                                dutyIds.push(level3.dutyParent + '_' + level3.dutyId + '_' + level6.dutyId);
                                                            }
                                                        });

                                                        if (newlevel6.length > 0 && !flag) {
                                                            newlevel6.forEach(function (level6) {
                                                                var newlevel7 = [];
                                                                level7.forEach(function (level7) {
                                                                    if (level6.dutyId == level7.dutyParent) {
                                                                        newlevel7.push(level7);
                                                                    }
                                                                });

                                                                if (newlevel7.length > 0) {
                                                                    newlevel7.forEach(function (level7) {
                                                                        var obj = {
                                                                            level: item,
                                                                            level1: {
                                                                                id: level1.dutyParent + '_' + level1.dutyId,
                                                                                dutyId: level1.dutyId,
                                                                                dutyName: level1.dutyName
                                                                            },
                                                                            level2: {
                                                                                id: level2.dutyParent + '_' + level2.dutyId,
                                                                                dutyId: level2.dutyId,
                                                                                dutyName: level2.dutyName
                                                                            },
                                                                            level3: {
                                                                                id: level3.dutyParent + '_' + level3.dutyId,
                                                                                dutyId: level3.dutyId,
                                                                                dutyName: level3.dutyName
                                                                            },
                                                                            level4: {
                                                                                id: level3.dutyParent + '_' + level3.dutyId + '_' + level4.dutyId,
                                                                                dutyId: level4.dutyId,
                                                                                dutyName: level4.dutyName
                                                                            },
                                                                            level5: {
                                                                                id: level3.dutyParent + '_' + level3.dutyId + '_' + level5.dutyId,
                                                                                dutyId: level5.dutyId,
                                                                                dutyName: level5.dutyName
                                                                            },
                                                                            level6: {
                                                                                id: level3.dutyParent + '_' + level3.dutyId + '_' + level6.dutyId,
                                                                                dutyId: level6.dutyId,
                                                                                dutyName: level6.dutyName
                                                                            },
                                                                            level7: {
                                                                                id: level7.dutyParent + '_' + level7.dutyId,
                                                                                dutyId: level7.dutyId,
                                                                                dutyName: level7.dutyName
                                                                            }
                                                                        }

                                                                        arr.push(obj);
                                                                    });
                                                                } else {
                                                                    var obj = {
                                                                        level: item,
                                                                        level1: {
                                                                            id: level1.dutyParent + '_' + level1.dutyId,
                                                                            dutyId: level1.dutyId,
                                                                            dutyName: level1.dutyName
                                                                        },
                                                                        level2: {
                                                                            id: level2.dutyParent + '_' + level2.dutyId,
                                                                            dutyId: level2.dutyId,
                                                                            dutyName: level2.dutyName
                                                                        },
                                                                        level3: {
                                                                            id: level3.dutyParent + '_' + level3.dutyId,
                                                                            dutyId: level3.dutyId,
                                                                            dutyName: level3.dutyName
                                                                        },
                                                                        level4: {
                                                                            id: level3.dutyParent + '_' + level3.dutyId + '_' + level4.dutyId,
                                                                            dutyId: level4.dutyId,
                                                                            dutyName: level4.dutyName
                                                                        },
                                                                        level5: {
                                                                            id: level3.dutyParent + '_' + level3.dutyId + '_' + level5.dutyId,
                                                                            dutyId: level5.dutyId,
                                                                            dutyName: level5.dutyName
                                                                        },
                                                                        level6: {
                                                                            id: level3.dutyParent + '_' + level3.dutyId + '_' + level6.dutyId,
                                                                            dutyId: level6.dutyId,
                                                                            dutyName: level6.dutyName
                                                                        },
                                                                        level7: ''
                                                                    }

                                                                    arr.push(obj);
                                                                }
                                                            });
                                                        } else if (!level5parents) {
                                                            var obj = {
                                                                level: item,
                                                                level1: {
                                                                    id: level1.dutyParent + '_' + level1.dutyId,
                                                                    dutyId: level1.dutyId,
                                                                    dutyName: level1.dutyName
                                                                },
                                                                level2: {
                                                                    id: level2.dutyParent + '_' + level2.dutyId,
                                                                    dutyId: level2.dutyId,
                                                                    dutyName: level2.dutyName
                                                                },
                                                                level3: {
                                                                    id: level3.dutyParent + '_' + level3.dutyId,
                                                                    dutyId: level3.dutyId,
                                                                    dutyName: level3.dutyName
                                                                },
                                                                level4: {
                                                                    id: level3.dutyParent + '_' + level3.dutyId + '_' + level4.dutyId,
                                                                    dutyId: level4.dutyId,
                                                                    dutyName: level4.dutyName
                                                                },
                                                                level5: {
                                                                    id: level3.dutyParent + '_' + level3.dutyId + '_' + level5.dutyId,
                                                                    dutyId: level5.dutyId,
                                                                    dutyName: level5.dutyName
                                                                },
                                                                level6: '',
                                                                level7: ''
                                                            }

                                                            arr.push(obj);
                                                        }

                                                        if (level5parents.indexOf(',' + level5.dutyId + ',') > -1) {

                                                            if (flag) {
                                                                var newarr = [];
                                                                arr.forEach(function (item, index) {
                                                                    if (level5parents.indexOf(',' + item.level5.dutyId + ',') > -1 && item.level5.dutyId != level5.dutyId) {
                                                                        newarr.push(index);
                                                                    }
                                                                });
                                                                if (newarr.length > 1) {
                                                                    arr[newarr[1]].level5.id = level3.dutyParent + '_' + level3.dutyId + '_' + level5.dutyId;
                                                                    arr[newarr[1]].level5.dutyId = level5.dutyId;
                                                                    arr[newarr[1]].level5.dutyName = level5.dutyName;

                                                                    level5parents = level5parents.replace(',' + level5.dutyId + ',', ',');
                                                                }
                                                            }

	                                                        flag = true;
                                                        } else {
                                                            flag = false;
                                                        }

                                                    });
                                                } else {
                                                    var obj = {
                                                        level: item,
                                                        level1: {
                                                            id: level1.dutyParent + '_' + level1.dutyId,
                                                            dutyId: level1.dutyId,
                                                            dutyName: level1.dutyName
                                                        },
                                                        level2: {
                                                            id: level2.dutyParent + '_' + level2.dutyId,
                                                            dutyId: level2.dutyId,
                                                            dutyName: level2.dutyName
                                                        },
                                                        level3: {
                                                            id: level3.dutyParent + '_' + level3.dutyId,
                                                            dutyId: level3.dutyId,
                                                            dutyName: level3.dutyName
                                                        },
                                                        level4: {
                                                            id: level3.dutyParent + '_' + level3.dutyId + '_' + level4.dutyId,
                                                            dutyId: level4.dutyId,
                                                            dutyName: level4.dutyName
                                                        },
                                                        level5: '',
                                                        level6: '',
                                                        level7: ''
                                                    }

                                                    arr.push(obj);
                                                }
                                            });
                                        } else if (!level3parents) {
                                            var obj = {
                                                level: item,
                                                level1: {
                                                    id: level1.dutyParent + '_' + level1.dutyId,
                                                    dutyId: level1.dutyId,
                                                    dutyName: level1.dutyName
                                                },
                                                level2: {
                                                    id: level2.dutyParent + '_' + level2.dutyId,
                                                    dutyId: level2.dutyId,
                                                    dutyName: level2.dutyName
                                                },
                                                level3: {
                                                    id: level3.dutyParent + '_' + level3.dutyId,
                                                    dutyId: level3.dutyId,
                                                    dutyName: level3.dutyName
                                                },
                                                level4: '',
                                                level5: '',
                                                level6: '',
                                                level7: ''
                                            }

                                            arr.push(obj);
                                        }

                                        if (level3parents.indexOf(',' + level3.dutyId + ',') > -1) {

                                            if (flag) {
                                                var newarr = [];
                                                arr.forEach(function (item, index) {
                                                    if (level3parents.indexOf(',' + item.level3.dutyId + ',') > -1 && item.level3.dutyId != level3.dutyId) {
                                                        newarr.push(index);
                                                    }
                                                });
                                                if (newarr.length > 1) {
                                                    arr[newarr[1]].level3.id = level3.dutyParent + '_' + level3.dutyId;
                                                    arr[newarr[1]].level3.dutyId = level3.dutyId;
                                                    arr[newarr[1]].level3.dutyName = level3.dutyName;

                                                    level3parents = level3parents.replace(',' + level3.dutyId + ',', ',');
                                                }
                                            }

                                            flag = true;
                                        } else {
                                            flag = false;
                                        }

                                    });
                                } else {
                                    var obj = {
                                        level: item,
                                        level1: {
                                            id: level1.dutyParent + '_' + level1.dutyId,
                                            dutyId: level1.dutyId,
                                            dutyName: level1.dutyName
                                        },
                                        level2: {
                                            id: level2.dutyParent + '_' + level2.dutyId,
                                            dutyId: level2.dutyId,
                                            dutyName: level2.dutyName
                                        },
                                        level3: '',
                                        level4: '',
                                        level5: '',
                                        level6: '',
                                        level7: ''
                                    }

                                    arr.push(obj);
                                }
                            });
                        } else {
                            var obj = {
                                level: item,
                                level1: {
                                    id: level1.dutyParent + '_' + level1.dutyId,
                                    dutyId: level1.dutyId,
                                    dutyName: level1.dutyName
                                },
                                level2: '',
                                level3: '',
                                level4: '',
                                level5: '',
                                level6: '',
                                level7: ''
                            }

                            arr.push(obj);
                        }
                    });
                });

			    return arr;
            }

			$(document).on('click', '.level', function(){
			    var dutyId = $(this).attr('dutyid');
			    layer.open({
				    type: 1,
				    title: '职责详情',
				    area: ['700px', '600px'],
				    content: '<div class="base_info">'+
								'<div class="label_item">'+
									'<div class="label_ttile"><span>职责名称：</span></div>'+
									'<div class="label_con"><span class="duty_name"></span></div>'+
								'</div>'+
								'<div class="label_item">'+
									'<div class="label_ttile"><span>职责类型：</span></div>'+
									'<div class="label_con"><span class="duty_type"></span></div>'+
								'</div>'+
								'<div class="label_item">'+
									'<div class="label_ttile"><span>上级职责：</span></div>'+
									'<div class="label_con"><span class="duty_parent"></span></div>'+
								'</div>'+
								'<div class="label_item">'+
									'<div class="label_ttile"><span>职责等级：</span></div>'+
									'<div class="label_con"><span class="duty_grade"></span></div>'+
								'</div>'+
								'<div class="label_item duty_desc_box" style="display: none;">'+
									'<div class="label_ttile"><span>关联岗位：</span></div>'+
									'<div class="label_con"><span class="job_ids"></span></div>'+
								'</div>'+
								'<div class="label_item duty_desc_box" style="display: none;">'+
									'<div class="label_ttile"><span>详细职责描述：</span></div>'+
									'<div class="label_con">'+
										'<pre class="duty_desc"></pre>'+
									'</div>'+
								'</div>'+
							'</div>',
                    success: function () {
                        var dutyInfo = treeObj[dutyId];

                        $('.duty_name').text(dutyInfo.dutyName);
                        $('.duty_type').text(dutyType[dutyInfo.dutyType]);
                        $('.duty_parent').text(dutyInfo.dutyParentName);
                        $('.duty_grade').text(dutyInfo.dutyGrade);

                        if (dutyInfo.isFinalNode == 0) {
                            $('.duty_desc_box').show(function () {
                                $('.duty_desc').text(dutyInfo.dutyDesc);
                                $('.job_ids').text(dutyInfo.jobNames);
                            });
                        }
                    }
			    });
			});

            var myChart = echarts.init(document.getElementById('myChart'));

            function loadTable(mergerDeptName, dutyJobType, queryType, dutyType) {
                var loadIndex = layer.load();
                $.get('/userJobDuty/shouJobDuty', {
                    mergerDeptName: mergerDeptName,
                    dutyJobType: dutyJobType,
                    dutyGrade: '',
                    queryType: queryType,
                    dutyType: dutyType
                }, function (res) {
                    if (res.flag) {
                        loadData(res.data);
                        var data = {
                            name: $('#mergerDeptName option[value="'+mergerDeptName+'"]').text(),
	                        children: res.data
                        }

                        myChart.setOption({
                            tooltip: {
                                trigger: 'item',
                                triggerOn: 'mousemove'
                            },
                            series: [{
                                type: 'tree',
                                data: [data],
                                left: 'center',
                                symbolSize: 7,
                                label: {
                                    position: 'left',
                                    verticalAlign: 'middle',
                                    align: 'right',
                                    fontSize: 16
                                },
                                leaves: {
                                    label: {
                                        position: 'right',
                                        verticalAlign: 'middle',
                                        align: 'left'
                                    }
                                },
                                emphasis: {
                                    focus: 'descendant'
                                },
                                initialTreeDepth: -1,
                                expandAndCollapse: true,
                                animationDuration: 550,
                                animationDurationUpdate: 750
                            }]
                        });
                    }
                    layer.close(loadIndex);
                });
            }

            function loadData(tree) {
                if (tree && tree.length > 0) {
                    tree.forEach(function(item){
                        item.name = item.dutyName;
                        // item.value = item.dutyName;

	                    if (item.child && item.child.length > 0) {
                            item.children = item.child;
                            item.collapsed = null;
                            loadData(item.child);
	                    }
                    });
                }
            }
		</script>
	</body>
</html>
