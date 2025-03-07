<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
	<link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
	<link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
	<link rel="stylesheet" type="text/css" href="../../css/dept/deptManagement.css"/>
	<link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/icon.css"/>
	<link rel="stylesheet" type="text/css" href="../../css/base.css"/>
	<link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
	<link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
	<link rel="stylesheet" type="text/css" href="../../css/dept/new_news.css"/>
	<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
	<script type="text/javascript" src="../../js/base/base.js"></script>
	<script src="/lib/layer/layer.js?20201106"></script>
	<script src="../../lib/laydate/laydate.js"></script>
	<script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<title>新建权限</title>
	<style>
		.newNew tr td {
			border: none;
		}

		.newNew .tableHead tr td {
			border: 1px solid #c0c0c0;
		}
		.close_but {
			width: 50px;
			height: 37px;
			margin-left: 0px;
			line-height: 28px;
			border-radius: 4px;
			padding-left: 4px;
			cursor: pointer;
			/*color:#fff;*/
		}

		.box {
			width: 300px;
			height: 150px;
			text-align: center;
			font-size: 20px;
			color: #fff;
			background: #2F8AE3;
			margin: 0 auto;
			line-height: 150px;
		}

		.success {
			text-align: center;
			display: none;
		}

		.box {
			margin-bottom: 30px;
		}

		.success span {
			width: 132px;
			height: 35px;
			background-color: rgba(224, 224, 224, 0.61);
			font-size: 16px;
			border-radius: 5px;
			padding-left: 8px;
			cursor: pointer;

			line-height: 30px;
			display: inline-block;
		}

		#clearSave {
			background: url(../../img/vote/clearsave.png) no-repeat;
			background-size: 181px;
			color: #fff;
			width: 181px;
			font-size: 16px;
			height: 30px;
			cursor: pointer;
			line-height: 30px;
			padding-left: 22px;
		}

		#save {
			background: url(../../img/vote/saveBlue.png) no-repeat;
			color: #fff;
			line-height: 30px;
			font-size: 16px;
			width: 91px;
			height: 30px;
			cursor: pointer;
			padding-left: 11px;

		}

		#refull {
			color: #000;
			width: 87px;
			line-height: 30px;
			height: 30px;
			cursor: pointer;
			font-size: 16px;
			background: url("../../img/vote/new.png") no-repeat;
			padding-left: 12px;

		}

		#addItem, #addChild {
			background: url(../../img/vote/save.png) no-repeat;
			color: #fff;
			width: 142px;
		}

		#addChild {
			background: url(../../img/vote/save.png) no-repeat;
			color: #fff;
		}

		#back {
			display: inline-block;
			width: 78px;
			height: 38px;
			line-height: 30px;
			cursor: pointer;
			border-radius: 3px;
			background: url(../../img/edu/eduSchoolCalendar/back.png) no-repeat;
			padding-left: 7px;
			font-size: 14px;
		}

		.laydate-footer-btns {
			position: absolute;
			right: 69px;
			top: 10px;
		}

		.layui-laydate-content {
			margin-left: 33px;
		}

		table tbody tr td {
			font-size: 11pt !important;
		}

		a {
			color: #1772c0;
		}
	</style>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">

<%--学生信息列表--%>

<div class="step1" style="display: block;margin-top: -20px">

	<div class="nav_box clearfix">
		<div class="nav_t1"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/xinjiantoupiao.png"></div>
		<div class="nav_t2" class="news">新建权限</div>
	</div>
	<table class="newNews">
		<tbody>
		<tr>
			<td class="blue_text">
				主管:
			</td>
			<td>
				<textarea name="textUser" id="textUser" style="width: 230px" disabled></textarea>
				<a href="javascript:;" class="governor" id="market_pop"><fmt:message code="global.lang.add"/></a>
				<a href="javascript:;" class="clearTwo" onclick="market_pop()"><fmt:message
						code="global.lang.empty"/></a>
			</td>
		</tr>
		<tr>
			<td class="blue_text">
				下属员工:
			</td>
			<td>
				<textarea name="" id="governor" style="width: 230px;height: 210px;" disabled></textarea>
				<a href="javascript:;" id="governor_pop" style="color:#1772c0"><fmt:message code="global.lang.add"/></a>
				<a href="javascript:;" class="clearTwo" style="color:#1772c0" onclick="governor_pop()"><fmt:message
						code="global.lang.empty"/></a>
			</td>
		</tr>
		</tbody>

		<div>
			<tr style="text-align:center">
				<td colspan="2">
					<button type="button" class="close_but" id="save" onclick="save()"><fmt:message code="global.lang.save"/></button>
					<button type="button" class="close_but" id="refull" onclick="javascript:window.location.href='/personBonusmsg/personSetting';">返回</button>
				</td>
			</tr>
		</div>
	</table>
	<div class="success">
		<div class="box"><fmt:message code="vote.th.successfullySaved"/>!</div>
		<div>
			<span id="addItem"><fmt:message code="vote.th.AddVotingItems"/></span>
			<span id="addChild"><fmt:message code="vote.th.AddSubVoting"/></span>
			<span id="back"><fmt:message code="notice.th.return"/></span>
		</div>
	</div>
</div>

</body>

<script type="text/javascript">
    var user_id = '';
    $('#market_pop').on("click",function () {
        user_id = 'textUser';
        $.popWindow("../common/selectUser?0");
    });
    $("#governor_pop").on("click", function () {//选人员控件
        user_id = 'governor';
        $.popWindow("../../common/selectUser");
    });
    //清除数据
    function market_pop() {
        $('#textUser').attr('user_id', '');
        $('#textUser').attr('user_id', '');
        $('#textUser').removeAttr('user_id');
        $('#textUser').val('');
    }
    function governor_pop() {
        $('#governor').removeAttr('user_id');
        $('#governor').removeAttr('user_id');
        $('#governor').attr('user_id', '');
        $('#governor').val('');
    }
    //新建保存
    function save() {
        var data={
            manager:$('#textUser').attr('user_id'),
            employee:$('#governor').attr('user_id'),
        }
        if($('#textUser').val()==''){
            layer.msg('请选择主管 ！',{icon:2});
        }else if($('#governor').val()==''){
            layer.msg('请选择人员 ！',{icon:2});
        }else{
            $.ajax({
                url: '/bonusPriv/setUpCrmManager',
                type: 'post',
                dataType: 'json',
                data:data,
                success: function (data) {
                    if(data.flag){
                        layer.msg('保存成功！',{icon:1},function () {
                            window.close();
                            window.location.href='/personBonusmsg/personSetting'
                        });/*添加成功*/
                    }else{
                        layer.msg('保存失败！',{icon:2});/*添加失败*/
                    }
                },
                error: function (data) {
                    layer.msg('保存失败！',{icon:2});/*添加失败*/
                }
            })
        }
    }

</script>
</html>
