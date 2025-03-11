<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String newsId = request.getParameter("newsId");
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>车辆审批详情</title>
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>

    <link rel="stylesheet" href="../../css/email/m/styles.css" />
    <link rel="stylesheet" href="../../css/email/m/style.css">
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <%--<script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>--%>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js?20190927.1"></script>


    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js" ></script>
    <style>
        #header{
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }
        #header a{
            color: #fff;
        }
        #header h1{
            color: #fff;
        }
        .nav span{
            width: 48%;
            display: inline-block;
            text-align: center;
        }
        .result,.result1{
            color:#00a0e9;
            padding-left: 17px;
        }
        .mui-input-row label{
            padding-left: 0;
            font-family:'microsoft yahei';
            width: 96px;
            margin-top: .2rem;
        }
        .mui-input-row label~input{
            float: left;
            padding: 10px 0;
            width: calc(100% - 120px);
        }
        .mui-content {
            height: calc(100% - 45px);
            background: #fff;
        }
        #forms label,#forms1 label,#forms3 label,#forms4 label{
            width: 400px;
        }
        .mui-input-row span{
            /*float: right;*/
            line-height: 40px;
        }
        .mui-bar-nav~.mui-content {
            height: 100%;
            background: #fff;
            overflow: auto;
        }
        .radio_inline{
            display: inline-block;
            width: 65%;
        }
        .radio_inline label{
            width: 20%;
            padding-left: 40px;
            padding-right: 40px;
        }
        .radio_inline input[type=radio]{
            width: 15%;
            right:auto;
        }
        .must{
            color: red;
        }
    </style>
</head>

<body data-role="page">
<div class="mui-content" id="content" style="overflow: auto;">
    <ul>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><span class="must">*</span>车牌号：</label><input type="text" name="vId" class="mui-input-clear vId" style="margin-top: .45rem;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left">用车人：</label><input type="text" class="mui-input-clear vuUser" name="vuUser" style="margin-top: 10px;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left">用车部门：</label><input type="text"  class="mui-input-clear vuDept  test_null" name="vuDept" style="margin-top: 10px;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left">跟随人员：</label><input type="text"  class="mui-input-clear vuSuite  test_null" name="vuSuite" style="margin-top: 10px;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row" id="demo"><span class="must">*</span>开始时间：<span class="result test_nullSpan" id="beginTime" name="vuStart">选择时间</span></li>
        <li class="mui-table-view-cell mui-input-row"id="demo1"><span class="must">*</span>结束时间：<span class="result1 test_nullSpan " id="endTime" name="vuEnd">选择时间</span></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left">目的地：</label><input type="text"  class="mui-input-clear vuDestination " name="vuDestination" style="margin-top: 10px;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left">申请里程：</label><input type="text"  class="mui-input-clear vuMileage" name="vuMileage" style="margin-top: 10px;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left" style="width: 2.1rem">部门审批人：</label><input type="text"  class="mui-input-clear deptManager " name="deptManager" style="margin-top: 10px;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left">调度员：</label><input type="text"  class="mui-input-clear vuOperator" name="vuOperator" style="margin-top: 10px;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left">事由：</label><input type="text"  class="mui-input-clear vuReason" name="vuReason" style="margin-top: 10px;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left">备注：</label><input type="text"  class="mui-input-clear vuRemark" name="vuRemark" style="margin-top: 10px;" value="" /></li>
    </ul>
    <div style="padding: 10px;">
        <button type="button" class="mui-btn mui-btn-primary ratify" style="margin-left: 30%;margin-right: .2rem">批准</button>
        <button type="button" class="mui-btn mui-btn-primary approved" >不批准</button>
    </div>
</div>

<script>
    var fs = document.documentElement.clientWidth / 750  * 100;
    document.querySelector("html").style.fontSize = fs + "px";
    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    var vuId = getQueryString('vuId')
    $(function(){
        $.ajax({
            url:"/veHicleUsage/getVehicleUsageDetail",
            type:'post',
            data:{
                vuId:vuId
            },
            dataType:'json',
            success:function(json){
                var data=json.obj;
                $('.vId').val(data.vIdNum)
                $('.vuUser').val(data.vuUserName)
                $('.vuDept').val(data.vuDeptName)
                $('.vuSuite').val(data.vuSuiteName)
                $('#beginTime').html(data.vuStart)
                $('#endTime').html(data.vuEnd)
                $('.vuDestination').val(data.vuDestination)
                $('.vuMileage').val(data.vuMileage)
                $('.deptManager').val(data.deptManagerName)
                $('.vuOperator').val(data.vuOperatorName)
                $('.vuReason').val(data.vuReason)
                $('.vuRemark').val(data.vuRemark)
            }
        })
    })
    $('.ratify').click(function(){
        $.ajax({
            url:'/veHicleUsage/editDeptApproval',
            type:'post',
            data:{
                vuId:vuId,
                dmerStatus:1,
                deptReason:'批准'
            },
            success:function (res) {
                window.location.href='/ewx/carApprovalList'
            }
        })
    })
    $('.approved').click(function () {
        $.ajax({
            url:'/veHicleUsage/editDeptApproval',
            type:'post',
            data:{
                vuId:vuId,
                dmerStatus:2,
                deptReason:'不批准'
            },
            success:function(res){
                window.location.href='/ewx/carApprovalList'
            }
        })
    })

</script>
</body>
</html>
