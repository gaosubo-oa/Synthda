<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>应用日志</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
<%--        <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/ui/js/qrcode.min.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
<%--    <script src="/lims/layui/layui.js"></script>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
<%--    <script type="text/javascript" src="/js/gapp/ming.js?20211208.4"></script>--%>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>

</head>
<style>
    html,body{
        height: 100%;
    }
    .cont_left {
        height: calc(100% - 60px);
        border-right: none;
        overflow-y: auto;
        width: 100%;
    }
    .top{
        padding-top: 10px;
        border-bottom: 1px solid rgb(230,230,230);
        height: 50px;
    }

    .menu_nva a {
        display: block;
        height: 38px;
        line-height: 38px;
        padding-left: 58px;
        color: #777777;
        background: #fff;
        text-decoration: none;

    }

    .menu_nva a:hover {
        text-decoration: none;
    }
    .left{
        display: inline-block;
        height: calc(100% - 72px);
        border-right: 1px solid #837f7f;
        float: left;
        width: 260px;
    }
    .layui-layer-btn .layui-layer-btn0{
        background-color: white;
        color: black;
        border:1px solid rgb(233,233,233);
        width: 50px;
        text-align: center;
        height: 40px;
        line-height: 40px;
        font-size: 18px;
        border-radius: 8px;
    }
    .layui-layer-btn .layui-layer-btn1{
        background-color: rgb(24,144,255);
        color: white;
        border:1px solid rgb(24,144,255);
        width: 50px;
        text-align: center;
        height: 40px;
        line-height: 40px;
        font-size: 18px;
        border-radius: 8px;
    }
    .layui-layer-title{
        height: 60px;
        line-height: 60px;
        border-bottom: 1px solid rgb(227,227,227);
        background-color: white;
    }
    .layui-layer-iframe .layui-layer-btn, .layui-layer-page .layui-layer-btn{
        border-top: 1px solid rgb(227,227,227);
    }
    #biao{
        width: 100px;
        height: 100px;
        font-size: 50px;
        display: inline-block;
        text-align: center;
        line-height: 100px;
        color: white;
        /*border-radius: 37px;*/
        margin-top: 25px;
        margin-left: 30px;
        background-repeat:no-repeat;
        background-size: 100px;
    }
    .bottom{
        width: 100%;
        height: 50px;
        position: absolute;
        left: 0;
        bottom: 0;
        border-bottom-right-radius: 10px;
        border-bottom-left-radius: 10px;
    }
    .tops{
        width: 100%;
        height: 50px;
        background-color: red;
        position: absolute;
        border-top-right-radius: 7px;
        border-top-left-radius: 7px;
        line-height: 28px;
    }
    .big:hover{
        -webkit-box-shadow: #ccc 0px 10px 10px;
        -moz-box-shadow: #ccc 0px 10px 10px;
        box-shadow: #ccc 0px 10px 10px;  }
    .all_ul{
        width: 100% !important;
        height: 100%;
        margin-left: 0% !important;
        background: #fff;
    }
    .tab_c{
        background: #f5f5f5;
        border-right: 2px solid #e9f0f5;
    }
    .tab_c{
        margin-left: 0% !important;
    }
    .tab_cone{
        color: #111!important;
    }
    .tab_cone .one:nth-child(1) {
        border-top: none;
    }
    .tab_cone li .one_all:hover{
        background: #b6e0ff !important;
    }
    .tab_cone{
        width: 100% !important;
        height:99% !important;
    }
    .yiji::-webkit-scrollbar {
        width: 10px;
    }
    .yiji::-webkit-scrollbar-thumb {
        border-radius: 50px;
        background-color: #bfbfbf;
    }
    .yiji::-webkit-scrollbar-track {
        border-radius: 50px;
        background-color: #ffffff;
    }
    .down_jiao{
        display: inline-block;
        width: 16px;
        position: absolute;
        right: 5px;
        top: 27px;
    }
    .er_img{
        display: inline-block;
        float: right;
        margin-top: -25px;
        margin-right: 10px;
    }
    #administ{
        display: inline-block;
    }
    .person{
        font-size: 9px;
    }
    /*一级菜单移入移出样式的改变*/
    .one_all li:hover{
        background:#ccebff;
        cursor:pointer;
    }
    .one_all li:hover h1{
        color:#2f8ae3;
    }
    .one_all{
        padding: 10px 0 10px 0;
        border: none;
        border-bottom: none;
        background: #f5f7f8 !important;
        border-top: 2px solid #fff!important;
    }
    .one_all{
        height: 40px !important;
        width: 100% !important;
        border-left: none !important;
        border-right: none !important;
    }
    .one_all{
        background: #f0f4f7 !important;
        position: relative;
    }
    .one_all .one_name{
        height: 40px;
        line-height: 40px;
        width: calc(100% - 30px);
    }
    .one_alltwo{
        background: #fff!important;
        height: 40px !important;
        width: 100% !important;
        border-left: none !important;
        border-right: none !important;
        border: none;
        border-bottom: none;
        border-top: 2px solid #fff!important;
        margin-top: 0%;
    }
    .one_alltwo h1{
        font-size: 18px;
        color: #2f8ae3;
    }
    .tab_cone li .one_all:hover{
        background: #b6e0ff !important;
    }
    .two{
        background: none!important;
    }
    .two .two_all:hover{
        color:#2f8ae3;
        background:#ccebff;
        cursor: pointer;
    }
    .two_all{
        width: 100%;

    }
    .two_all h1{
        width: 66%;
        margin-left: 0;
        color: #111;
        text-shadow: none;
        padding-left: 55px;
        height: 45px;
        line-height: 45px;
    }
    .three:hover{
        color:#2f8ae3;
        background:#ccebff;
    }
    .three{
        background: rgb(232, 244, 252);
    }
    .three h1{
        color: #333;
        text-shadow: none;
        height: 40px;
        line-height: 40px;
    }
    .sanji .three:hover{
        background: #ccebff;
    }
    .lists{
        width: 355px;
        background-color: white;
        position: fixed;
        padding: 3px;
        border: 1px solid rgb(239,239,239);
        z-index: 99999;
        display: none;
        height: 179px;
        overflow: auto;
    }
    .list1{
        border: 1px solid rgb(239,239,239);
        padding: 3px;
    }
    .list1 div{
        margin-top: 5px;
    }
    .list1 div:hover{
        background-color: rgb(246,246,246);
        cursor:pointer;
    }
    .list1 div:nth-child(1){
        margin-top: 0px;
    }
    .list1 div:nth-child(2){
        margin-top: 0px;
    }
    .list1 div:nth-child(3){
        margin-top: 0px;
    }
    .list1 div:nth-child(4){
        margin-top: 0px;
    }
    .list1 div:nth-child(5){
        margin-top: 0px;
    }
    #oneDaySalaryRatio{
        background-image: url("/img/gapp/1.png");
        background-repeat:no-repeat;
        background-size: 30px;
        background-position: 10px;
    }
    #userName::-webkit-input-placeholder{
        font-size:22px;
    }
    .tbox {
        margin: 0 auto; /*水平居中*/
        position: relative;
        margin-top:20px;
    }
    .layui-form-item {
        margin-bottom: 5px;
    }
    .tbox .layui-form-item .layui-form-label{
        width: 120px;
        text-align: right;
    }
    .tbox .layui-form-item .layui-input-block{
        margin-left: 170px;
        width: 60%;
    }


    .infoBox{
        position: relative;
        width: 100%;
        float: left;
        margin-right: 0px;
    }
    .infoBox2 {
        position: relative;
        margin-top: 38px;
    }
    .infoBoxss input{
        height: 32px;
    }
    .infoBoxs input{
        height: 32px;
    }
</style>
<body>
<div class="top">
    <div style="margin-left: 15px;color:#2f8ae3;display: inline-block;font-width: bold;font-size: 24px;line-height: 38px;height: 38px;" id="ying"><img style="width: 22px;display: inline-block" src="/img/gapp/app_logs.png" alt="">&nbsp;&nbsp;应用日志</div>
</div>
<div class="layui-colla-content layui-show" style="border:none;padding: 0 16px;padding-bottom: 20px;">
    <form class="layui-form" id="secBox">
        <div class="layui-form-item" style="margin-bottom: 0px;">
            <div class="layui-row layui-col-space10">
                <div class="layui-col-md2" style="width: 160px">
                    <div class="infoBox infoBoxss layui-inline-block">
                        <label class="layui-form-label" style="padding: 9px 0px;width:100%;text-align: left;font-weight: bold;">操作人</label>
                        <a onclick="selectUser($(this))">
                            <input type="text" name="opUser"  style="cursor: pointer;" readonly placeholder="请选择"
                                   id="opUser" autocomplete="off" class="layui-input" lay-verify="required" >
                        </a>
                    </div>
                </div>
                <div class="layui-col-md2" style="width: 160px">
                    <div class="infoBox infoBoxss layui-inline-block">
                        <label class="layui-form-label" style="padding: 9px 0px;width:100%;text-align: left;font-weight: bold;">操作应用</label>
                        <input type="text" name="opAppName"    placeholder="请输入名称"
                               id="opAppName" autocomplete="off" class="layui-input" lay-verify="required" >
                    </div>
                </div>
                <div class="layui-col-md2" style="width: 160px">
                    <div class="infoBox infoBoxss layui-inline-block">
                        <label class="layui-form-label" style="padding: 9px 0px;width:100%;text-align: left;font-weight: bold;">操作对象</label>
                        <div style="float: left;width: 100%;">
                            <select  class="layui-input st11" name="opObject" id="opObject" lay-filter="opObject" lay-verify="required" >

                            </select>
                        </div>

                    </div>
                </div>
                <div class="layui-col-md6"style="width: 460px">
                    <div class="infoBox infoBoxs layui-inline-block">
                        <label class="layui-form-label" style="padding: 9px 0px;width:100%;text-align: left;font-weight: bold;">操作时间</label>
                        <div style="width: calc(70% - 2px);float: left;">
                            <div  style="float: left;width: calc(50% - 15px);" >
                                <input type="text" readonly style="cursor:pointer;" autocomplete="off" id="startOpTime" class="layui-input" placeholder="开始时间">
                            </div>
                            <div style="cursor:pointer;margin:0px!important;text-align:center;float: left;line-height: 30px;display: block;height: 30px;width: 20px;">-</div>
                            <div style="float: left;width: calc(50% - 15px);">
                                <input type="text" readonly style="cursor:pointer;" autocomplete="off" id="endOpTime" class="layui-input" placeholder="结束时间">
                            </div>
                        </div>
                        <button type="button" style="height: 32px;line-height: 32px;padding: 0 10px;background-color: rgb(64,147,243)" class="layui-btn layui-btn-sm search">搜索</button>
                    </div>
                </div>
                <%--<div class="layui-col-md4">--%>
                    <%--<div class="infoBox infoBox2 layui-inline-block">--%>
                        <%--<div style="width: 100%;">--%>
                            <%----%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            </div>





        </div>
    </form>


    <table class="layui-table" style="margin-top: 0px;" lay-skin="line" id="logTable" lay-size="sm" lay-filter="logTableFilter"></table>

    </div>

</body>
<script>
    var logTable;
    layui.use(['table', 'laydate', 'layer', 'form', 'element', 'laytpl'], function () {
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var $ = layui.jquery;
        var laydate = layui.laydate;
        var element = layui.element;
        var eleTree = layui.eleTree;
        var laytpl = layui.laytpl;
        var soulTable = layui.soulTable;
        form.render()
        laydate.render({
            elem: '#startOpTime'
            ,type: 'datetime'
            , done: function (value, date, endDate) {
                var startOpTime = value;
                var endOpTime = $("#endOpTime").val();
                var start = new Date(startOpTime.replace("-", "/").replace("-", "/"));
                var end = new Date(endOpTime.replace("-", "/").replace("-", "/"));
                if (end < start) {
                    $("#testFinalTime").val("")
                    $("#editCycleTime").val("")
                    layer.msg('开始时间不能晚于结束时间！', {icon: 1});
                    return false;
                }
            }
        });


        laydate.render({
            elem: '#endOpTime'
            ,type: 'datetime'
            , done: function (value, date, endDate) {
                var startOpTime=$("#startOpTime").val();
                var endOpTime=value;
                var start = new Date(startOpTime.replace("-", "/").replace("-", "/"));
                var end = new Date(endOpTime.replace("-", "/").replace("-", "/"));
                if(end < start){
                    $("#testFinalTime").val("")
                    $("#editCycleTime").val("")
                    layer.msg('结束时间不能早于开始时间！', {icon: 1});
                    return false;
                }
            }
        });


        var str = '<option value="">请选择</option>\n' +
            '                <option value="0">应用设计</option>\n' +
            '                <option value="1">使用数据</option>'

        $('#opObject').html(str);
        form.render('select');

        logTable = table.render({
            elem: '#logTable'
            , url: '/gappLogs/selectGappLogs?useFlag=true'//数据接口
            ,page: true
            ,limit:10
            , cols: [[//表头
                {field: 'opUserName', title: '操作人'},
                {
                    field: 'opTyep', title: '操作类型', templet: function (d) {
                        if (d.opTyep == '0') {
                            return "删除";
                        } else if (d.opTyep == '1') {
                            return "编辑";
                        }else if (d.opTyep == '2') {
                            return "新增";
                        }
                    }
                },
                {field: 'opTime', title: '操作时间'},
                {field: 'opAppName', title: '操作应用'},
                {
                    field: 'opObject', title: '操作对象', templet: function (d) {
                        if (d.opObject == '0') {
                            return "应用设计";
                        } else if (d.opObject == '1') {
                            return "使用数据";
                        } else  {
                            return "";
                        }
                    }
                },
                {field: 'opDesc', title: '操作内容'},
            ]]
            ,done: function (res) {

            }
            , parseData: function (res) { //res 即为原始返回的数据
                // var data = json.obj
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.obj, //解析数据列表
                };
            }
        });
    })
    function selectUser(e){
        user_id = 'opUser';
        $.popWindow("../common/selectUser?0");
    }
    //搜索
    $(".search").on('click',function(){
        var atr =$("#opUser").attr("user_id");
        var opAppNames=$("#opAppName").val();//操作应用
        var opObjects =$("#opObject").next('.layui-form-select').find("dl dd.layui-this").attr("lay-value");
        var startOpTimes =$("#startOpTime").val()
        var endOpTimes=$("#endOpTime").val()

        if(atr != "undefined" && atr != undefined){
            var opUsers =atr.substring(0,atr.length-1)
        }else{
          var  opUsers =''
        }
        if(opAppNames != "undefined" && opAppNames != undefined){
            opAppNames =opAppNames
        }else{
            opAppNames =''
        }
        if(opObjects != "undefined" && opObjects != undefined){
            opObjects =opObjects
        }else{
            opObjects =''
        }
        if(startOpTimes != "undefined" && startOpTimes != undefined){
            startOpTimes =startOpTimes
        }else{
            startOpTimes =''
        }
        if(endOpTimes != "undefined" && endOpTimes != undefined){
            endOpTimes =endOpTimes
        }else{
            endOpTimes =''
        }

        $.ajax({
            url: '/gappLogs/selectGappLogs',
            type: 'get',
            dataType: 'json',
            data: {
                opUser:opUsers,
                opAppName:opAppNames,
                opObject:opObjects,
                startOpTime:startOpTimes,
                endOpTime:endOpTimes
            },
            success: function (res) {
                if(res.flag){
                    layui.layer.msg(res.msg)
                    if(res.obj.length>0){
                        logTable.reload({
                            url:'',
                            data:res.obj,
                            useFlag:true,
                            page: {
                                curr: 1
                            }
                        })
                    }else if(res.obj.length == 0){
                        logTable.reload({
                            url:'',
                            data:res.obj,
                            useFlag:true,
                            page: {
                                curr: 1
                            }
                        })
                    }

                }else{
                    layui.layer.msg(res.msg)
                }
            }
        })
    })
</script>
</html>
