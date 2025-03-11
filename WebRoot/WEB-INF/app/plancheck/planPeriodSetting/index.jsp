<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>计划期间设置</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/common.css">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
		<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
		<script src="/lib/layui/layui/layui.js"></script>
		<script src="/js/jquery/jquery.form.min.js"></script>
		<script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
		<script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
		<script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
		<style>
			.layui-form-label {
				width: 100px;
			}

			.layui-input-block {
				margin-left: 130px;
			}

			.layui-disabled, .layui-disabled:hover {
				color: #797979 !important;
			}

			.ztree * {
				font-size: 11pt !important;
			}

			#questionTree li {
				border-bottom: 1px solid #ddd;
				line-height: 40px;
				padding-left: 10px;
				cursor: pointer;
				border-radius: 3px;
			}

			.select {
				background: #c7e1ff;
			}

			.layui-table-tool {
				min-height: 40px;
				padding: 5px 15px;
			}

			.layui-form-item {
				margin: 0px;
			}
		</style>
		<link rel="stylesheet" href="/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
		<script type="text/javascript" src="/lib/zTree_v3/js/jquery.ztree.all.min.js"></script>

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
		<%--<div style="padding-top: 5px;position: relative;">
			<img src="../../img/addcodemain.png" style="position: absolute;left: 22px;top:9px "><span style="margin-left: 49px;font-size: 20px;">计划期间设置</span>
		</div>
		&lt;%&ndash;蓝色分割线&ndash;%&gt;
		<hr class="layui-bg-blue" style="height: 5px">--%>
		<div class="layui-fluid" id="LAY-app-message-1">
			<input type="hidden" id="sortId-1">
			<div class="layui-row ">
				<div class="layui-lf" style="width:250px;float:left">
					<div class="layui-card">
						<div class="layui-card-body" id="leftHeight" style="height:650px;position:relative;">
							<div style="margin-bottom:10px;text-align: center">
								计划年份
							</div>
							<ul id="questionTree" style="position: absolute;overflow:auto;top: 34px;right: 15px;bottom: 0;left: 15px;">
							</ul>

						</div>
					</div>
				</div>
				<div class="layui-form-item" style="display: none">
					<label class="layui-form-label">1标题</label>
					<div class="layui-input-block">
						<input type="text" id="periodId" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-rt rightHeight" style="width:calc(100% - 250px);float:left;">
					<div class="layui-card" style="height: 100%;padding-left: 11px;">
						<div class="layui-fluid" id="LAY-app-message" style="padding: 0;">
							<input type="hidden" id="sortId">
							<div class="layui-row ">

								<div class="layui-card" style="width:100%;">
									<div class="layui-card">
										<style>
											.layui-card-header .layui-icon {
												top: auto !important;
											}
										</style>
										<div id="queryarea_searchView"></div>
										<div class="layui-card-body">
											<div class="layui-form-item">
												<div class="layui-inline" style="">
													<label class="layui-form-label" style="width:45px;padding: 9px 5px">年份</label>
													<div class="layui-input-inline" style="width: 150px;">
														<input type="text" value=" " id="year" name="price_min" placeholder="" autocomplete="off"
														       class="layui-input user">
													</div>
												</div>
												<div class="layui-inline">
													<button type="button" class="layui-btn search layui-btn-sm" id="query" style="display: none;">查询</button>
												</div>
											</div>
											<div>
												<table id="questionTable" lay-filter="questionTable-table"></table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script id="barOperation" type="text/html" lay-filter="toolBtn">
			<%--        <button type="button" class="layui-btn  layui-btn-xs"  lay-event="preview">预览</button>--%>
			{{#  if(authorityObject && authorityObject['05']){ }}
			<button type="button" class="layui-btn layui-btn-xs " lay-event="edit">编辑</button>
			{{#  } }}
			{{#  if(authorityObject && authorityObject['04']){ }}
			<button type="button" class="layui-btn  layui-btn-xs layui-btn-danger " lay-event="del">删除</button>
			{{#  } }}
		</script>
		<script type="text/html" id="toolbar">
			<div class="layui-btn-container">
				{{# if(authorityObject && authorityObject['01']){ }}
				<button class="layui-btn layui-btn-sm" style="margin: 0;" id="addMonth" lay-event="add">新增</button>
				{{# } }}
			</div>
		</script>
	</body>
</html>
<script>

    initAuthority();

    resizeSize();

    window.onresize = resizeSize;

    var form = null;

    var type = $.GetRequest().type;
    var dataType = $.GetRequest().dataType;
    var shitiType = ''

    function getlis() {
        $.ajax({
            url: '/planPeroidSetting/selectAllYear',
            type: 'get',
            dataType: 'json',
            success: function (res) {
                if (res.code == 0) {
                    var data = res.object;
                    var str = ''
                    for (var i = 0; i < data.length; i++) {
                        if (i == 0) {
                            str += '<li class="select" value="' + data[i].periodYear + '"   dictId="' + data[i].periodId + '">' + data[i].periodYear + '</li>'
                        } else {
                            str += '<li value="' + data[i].periodYear + '"  dictId="' + data[i].periodId + '" >' + data[i].periodYear + '</li>'
                        }
                    }
                    $('#questionTree').html(str);
                }
            }
        })
    }

    getlis();
    layui.use(['table', 'layer', 'laydate', 'form', 'element', 'eleTree'], function () {
        var table = layui.table;
        var layer = layui.layer;
        form = layui.form;
        var laydate = layui.laydate;
        var eleTree = layui.eleTree;
        var element = layui.element;
        form.render();
        laydate.render({
            elem: '#year' //指定元素
            , type: 'year'
			,trigger:'click'
        });
        $('#questionTree').on('click', 'li', function () {
            $(this).addClass('select').siblings().removeClass('select');
            var periodYear = $('.select').attr('value')
            if (periodYear !== undefined) {
                tableIns.reload({
                    where: { //设定异步数据接口的额外参数，任意设
                        periodYear: periodYear
                    }
                });
            }
        })
        //表格渲染
        var tableIns = table.render({
            elem: '#questionTable'
            , url: '/planPeroidSetting/showAllSet'  //数据接口
            , where: {
                periodYear: $('.select').attr('value'),
            }
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.object //解析数据列表
                };
            }
            , height: 'full-140'
            , toolbar: '#toolbar'
            , defaultToolbar: ['']
            , cols: [[ //表头
                {field: 'periodMonth', align: 'center', title: '月份'}
                , {field: 'startDate', align: 'center', title: '起始时间'}
                , {field: 'endDate', align: 'center', title: '终止时间'}
                , {fixed: 'right', title: '操作', align: 'center', toolbar: '#barOperation'}
            ]]
            , limit: 12
        });
        //查询
        $('.search').on("click",function () {
            var periodYear = document.getElementById("year").value
            if (periodYear !== undefined) {
                tableIns.reload({
                    where: { //设定异步数据接口的额外参数，任意设
                        periodYear: periodYear
                    }
                });
            }
        })
        //监听事件
        table.on('toolbar(questionTable-table)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'add':
                    add(0)
                    break;
            }
            ;
        });
        // 监听操作工具条
        table.on('tool(questionTable-table)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if (layEvent === 'del') { //删除
                layer.confirm('确定要删除吗?', function (index) {
                    $.ajax({
                        type: 'post',
                        url: '/planPeroidSetting/deletePlanPeriodSet',
                        dataType: 'json',
                        data: {periodId: data.periodId},
                        success: function (res) {
                            $('#query').click();
                            if (res.msg) {
                                layer.msg('删除成功！', {icon: 1});
                                tableIns.reload()
                            }

                        }
                    })
                    layer.close(index);
                });
            } else if (layEvent == 'edit') { //编辑
                add(1, data)
            }
        });

        function add(type, editData) {
            var title
            var url
            if (type == 0) {
                title = '新增'
                url = '/planPeroidSetting/insertPlanPeriodSet'
            } else if (type == 1) {
                title = '编辑'
                url = '/planPeroidSetting/updatePeriod'
            }
            layer.open({
                type: 1,
                title: title,
                area: ['500px', '300px'],
                btn: ['确定', '取消']
                , maxmin: true,
                content: '<div><div class="layui-form" action="" style="margin-top: 45px;\n' +
                    '    border: none;\n' +
                    '    padding-bottom: 30px;">\n' +

                    ' <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">起始日期</label>\n' +
                    '    <div class="layui-input-block" style="width: 60%;">\n' +
                    '      <input type="text" class="layui-input" id="startDate"  style="display: inline-block;">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    ' <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '    <label class="layui-form-label">终止日期</label>\n' +
                    '    <div class="layui-input-block" style="width:60%;">\n' +
                    '      <input type="text" class="layui-input" id="endDate" style="display: inline-block;">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '</div></div>',
                success: function () {
                    //编辑回显
                    if (type == '1') {
                        $('#startDate').val(editData.startDate)
                        $('#endDate').val(editData.endDate)
                    }
                    laydate.render({
                        elem: '#startDate' //指定元素
						,trigger:'click'
                    })
                    laydate.render({
                        elem: '#endDate' //指定元素
						,trigger:'click'
                    });
                }
                , yes: function (index) {
                    var startDate = document.getElementById("startDate").value
                    var endDate = document.getElementById("endDate").value
					if (startDate==""){
						layer.msg('请选择起始日期！', {icon: 2});
						return
					}
					if (endDate==""){
						layer.msg('请选择终止日期！', {icon: 2});
						return
					}
					if (endDate<startDate){
						layer.msg('终止日期不得小于起始日期！', {icon: 2});
						return
					}
                    var params = {
                        startDate: startDate,
                        endDate: endDate,
                    }
                    if (type == 1) {
                        params.periodId = editData.periodId
                    }
                    $.ajax({
                        type: 'post',
                        url: url,
                        dataType: 'json',
                        data: params,
                        success: function (res) {
                            $('#query').click();
                            if (res.msg) {
                                if (type == 0) {
                                    layer.msg('新增成功！', {icon: 1});
                                    layer.close(index);
                                    tableIns.reload()
                                    getlis();
                                } else {
                                    layer.msg('修改成功！', {icon: 1});
                                    layer.close(index);
                                    tableIns.reload()
                                }

                            }
                        }
                    })
                }
            });
        }
    });

    // 初始化页面操作权限
    function initAuthority() {
        // 是否设置页面权限
        if (authorityObject) {
            // 检查查询权限
            if (authorityObject['09']) {
                $('#query').show();
            }
        }
    }

    function resizeSize() {
        var height = $(window).height()
        $('#leftHeight').height(height - 80)
    }

</script>
