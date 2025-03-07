<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/3/17
  Time: 9:55
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
		<title>任务中心设置</title>

		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
		<script src="/js/base/base.js"></script>

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

			.container {
				position: relative;
				width: 100%;
				height: 100%;
				padding-top: 46px;
				box-sizing: border-box;
			}

			.wrapper {
				position: relative;
				width: 100%;
				height: 100%;
				padding: 8px;
				box-sizing: border-box;
			}

			.wrap_left {
				position: relative;
				float: left;
				width: 230px;
				height: 100%;
				padding-right: 10px;
				box-sizing: border-box;
			}

			.wrap_right {
				position: relative;
				height: 100%;
				margin-left: 230px;
				overflow: auto;
			}

			.header {
				position: absolute;
				top: 0px;
				left: 0px;
				width: 100%;
				height: 45px;
				border-bottom: 1px solid #999;
				background: #fff;
				overflow: hidden;
				z-index: 2;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<div class="header">
				<div class="headImg" style="padding-top: 7px">
					<span style="font-size:22px; margin-left:10px; color:#494d59; margin-top: 2px">
						<img style="margin-left:1.5%; margin-top: -3px;" src="/img/commonTheme/theme6/icon_summary.png">
						<span style="margin-left: 10px">任务中心设置</span>
					</span>

					<button id="save" class="layui-btn layui-btn-normal layui-btn-sm" style="float: right; margin-right: 10%;">保存</button>
				</div>
			</div>
			<div class="content" style="width: 80%; margin: 0 auto;">
				<div class="eleTree ele1"></div>
			</div>
		</div>

		<script>
			layui.use(['eleTree'], function(){
			    var eleTree = layui.eleTree;

			    var treeObj = null;

                getGlobalSettings(function (res) {
                    var checkedKeys = [];
                    if (res.object) {
                        checkedKeys = res.object.split(',');
                    }
                    treeObj = eleTree.render({
                        elem: '.ele1',
                        data: res.data,
	                    expandOnClickNode: false,
                        highlightCurrent: false,
                        showLine: true,
                        defaultExpandAll: true,
	                    checkOnClickNode: true,
	                    showCheckbox: true,
	                    defaultCheckedKeys: checkedKeys,
                        request: {
                            key: 'fId',
                            name: 'name',
                            children: "child",
                        }
                    });
                });

                $('#save').on('click', function(){
                    var checkNodes = treeObj.getChecked(true);
                    console.log(checkNodes);
                    var taskSet = [];
                    checkNodes.forEach(function(node) {
                        taskSet.push(node.fId);
                    });
                    var params = {
                        operation: 'save',
	                    taskSet: taskSet.join(',')
                    }
                    getGlobalSettings(function(res){
                        if (res.flag) {
                            layer.msg('保存成功！', {icon: 1, time: 2000}, function () {
                                location.reload();
                            });
                        } else {
                            layer.msg('保存失败！', {icon: 2});
                        }
                    }, params);
                });
			});

            function getGlobalSettings(fn, params) {
                params = params || {}
                $.get('/userPrivateSet/globalSettings', params, function (res) {
                    if (fn) {
                        fn(res);
                    }
                });
            }
		</script>
	</body>
</html>
