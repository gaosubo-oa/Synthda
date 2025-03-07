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
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title>搜索</title>
    <link rel="stylesheet" href="/lib/layui/layuiadmin/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../../../js/base/base.js"></script>
    <script type="text/javascript" src="../../../js/ewx/waterMark.js?20190819.2"></script>
    <%--    echarts--%>
    <script type="text/javascript" src="/js/echarts.min.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <link rel="stylesheet" type="text/css" href="../../css/diary/m/diary_base.css"/>
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        .box{
            box-sizing: border-box;
            padding: 0.7rem;
            width: 100%;
            display: flex;
        }
        .cont{
            display: flex;
            flex-direction: column;
            font-size: 0.6rem;
            flex: 1;
        }
        .cont .main{
            display: flex;
            align-items: center;
            margin: 12px 10px;
        }

        .cont input{
            width: 70%;
        }
        .tit{
            width: 20%;
        }
        .form-control{
            height: 24px;
            font-size:0.56rem;
            padding: 0.1rem 0.2rem;
        }

        .btn{
            padding: 0px 0.2rem;
            width: 100%;
        }
        .btn button{
            color: #fff;
            border: 1px solid #598fde;
            background-color: #598fde;
            display: block;
            width: 100%;
            font-size: 0.56rem;
            padding: 8px 0;
            cursor: pointer;
            border-radius: 0.1rem;
        }
    </style>
</head>

<body>
    <div class="box">
        <div class="cont">
            <div class="main" style="font-size:13px">
                <div class="tit" >时间范围</div>
                <input style="width: 30%;font-size:13px" type="text" class="form-control" id='time1' name='DIA_DATE1' onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" placeholder="请选择汇报时间" />
                <span style="margin:0 0.2rem">至</span>
                <input style="width: 30%;font-size:13px" type="text" class="form-control" name='DIA_DATE2' id='time2' onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" placeholder="请选择汇报时间"/>
            </div>
            <div class="main">
                <div class="tit" style="font-size:13px">发起人</div>
                <input type="text" class="form-control" style="font-size:13px" name='USER_NAME' id="userName" placeholder="请输入发起人" />
            </div>
            <div class="main">
                <div class="tit" style="font-size:13px">汇报上级</div>
                <input type="text" class="form-control" style="font-size:13px" name='TD_NAME' id="userTopName" placeholder="请输入汇报上级" />
            </div>
            <div class="main">
                <div class="tit" style="font-size:13px">日志类型</div>
                <select name='DIA_TYPE' id="diaType" class="form-control" style='width:73%;height: 30px'>
                    <option value=''>--请选择--</option>
                    <option value='0'>日报</option>
                    <option value='1'>周报</option>
                    <option value='2'>月报</option>
                </select>
            </div>
        </div>
    </div>
    <div class="btn">
        <button type="submit" style="font-size:13px" class="query">查询</button>
    </div>
</body>

</html>
<script type="text/javascript">
    $('.query').on('click',function(){
        var time1 = $('#time1').val()
        var time2 = $('#time2').val()
        var userName = $('#userName').val()
        var userTopName = $('#userTopName').val()
        var diaType = $('#diaType').val()
        location.href = "/ewx/iStartedList?type=logQuery&time1=" + time1 +'&time2=' + time2 +'&userName='+ userName +'&userTopName='+ userTopName +'&diaType=' + diaType;
    })
</script>
