<%--
  Created by IntelliJ IDEA.
  User: gaosubo3000
  Date: 2020/9/25
  Time: 15:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>云广通视频会议申请</title>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js" ></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js?0923" type="text/javascript" charset="utf-8"></script>
</head>
<style>
    /*.nav{*/
    /*width: 70%;*/
    /*overflow: hidden;*/
    /*text-overflow: ellipsis;*/
    /*white-space: nowrap;*/
    /*height: 22px;*/
    /*line-height: 22px;*/
    /*margin-top: 15px;*/
    /*}*/
    #header{
        background-color: #0089e8;
        box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
    }
    #header a{
        color: #fff;
    }
    #header h1{
        color: #fff;
    }
    .ulli{
        margin: 6px 20px;
        border-bottom: 1px solid #c8c7cc;
        height: 60px;
        line-height: 58px;
    }

    .ulli input{
        width: 70%;
        margin-left: 2%;
        height: 30px;
        margin-top: 22px;
        border: none;
    }
    .nav{
        height: 31px;
        line-height: 28px;
        border: 1px solid #e1dddd;
        border-radius: 10px;
        width: 66%;
        margin-top: 13px;
        margin-right: 27px;
    }
    .nav span{
        width: 48%;
        display: inline-block;
        text-align: center;
    }
    .navc{
        background-color: #00a0e9;
        color: #fff;
        border-radius: 10px;
    }
    .fl{
        float: left;
    }
    .fr{
        float: right;
    }
    .spanc{
        background-color: #00a0e9;
        width: 40px;
        display: inline-block;
        text-align: center;
        height: 22px;
        line-height: 21px;
        border-radius: 6px;
        color: #fff;
    }
    #yspan{
        padding: 4px 10px;
        background-color: #00a0e9;
        color: #fff;
        border-radius: 5px;
        margin-left: 14px;
    }
    .result,.result1{
        color:#00a0e9;
        padding-left: 17px;
    }
    .textareaRen{
        width: 48% !important;
    }
    .add{
        color: red;
    }
    .clear{
        color: #2b7fe0;
    }
    .mui-icon-plus{
        margin-top: 10px;
        position: absolute;
        right: 0;
        top: 16px;
    }
    .mui-checkbox, .mui-radio {
        position: relative;
        height: 40px;
    }
</style>
<body >
    <div class="box" id="box">
        <header data-role="header" class="mui-bar mui-bar-nav" id="header">
            <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"  onclick="back()"></a>
            <h1 class="mui-title" id="mtitle">云广通视频会议申请</h1>
            <a href="javascript:;" id="add" class="mui-pull-right saveBtn"  style="padding-top: 14px;padding-right: 5px;" >保存</a>
        </header>
        <div class="mui-content" style="overflow: auto;">
            <ul>
                <li class="ulli">会议地点：<input class="meetAddress"></li>
                <li class="ulli">最大用户数：<input class="maxUser" id="maxUser" type="number"  ></li>
                <li class="ulli">会议名称：<input type="text" name="meetName"></li>
                <li class="ulli">会议密码：<input class="roomPwd" name="roomPwd" type="text"></li>
                <li class="ulli">会议时间：<input style="width: 30%;"  name="startTime" type="text" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">到
                    <input style="width: 30%;"  name="endTime" type="text" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
                </li>

                <li class="ulli" style="position: relative"><label class="mui-left" >会议主持人：</label>
                    <input type="text" placeholder="选择联系人" value="" class="mui-input-clear" id="hostUserId"/>
                    <input value="" type="hidden"  id="hostUser" /><span id="Popover_0" class='mui-icon mui-icon-plus'  style="margin-top: 10px"></span>
                </li>

                <li class="ulli" style="position: relative"><label class="mui-left" >会议纪要员：</label>
                    <input type="text" placeholder="选择联系人" value="" class="mui-input-clear" id="summaryUserId"/>
                    <input value="" type="hidden"  id="summaryUser" /><span id="Popover_1" class='mui-icon mui-icon-plus'  style="margin-top: 10px"></span>
                </li>

                <li class="ulli" style="position: relative"><label class="mui-left" >参会人员：</label>
                    <input type="text" placeholder="选择联系人" value="" class="mui-input-clear" id="userIds"/>
                    <input value="" type="hidden"  id="user" /><span id="Popover_3" class='mui-icon mui-icon-plus'  style="margin-top: 10px"></span>
                </li>

                <li class="mui-table-view-cell mui-input-row">
                    <label class="mui-left" style="padding:11px 0px;margin-top: .2rem;    width: 40%;">查看范围（部门）：</label>
                    <input type="text" placeholder="选择查看部门" style="    width: 58%;" id="deptId"  value="" class="mui-input-clear" />
                    <input value="" type="hidden" id="copyreciever"/>
                    <span id="Popover_5" class='mui-icon mui-icon-plus' style="right: 18px;"></span>
                </li>
                <li class="ulli">提醒参会人员：
                    <div class="news_t" style="display: inline-block;    width: 60%;">
                        <input type="checkbox" name="isAttend " class="textareaRen" num="1" style="    width: 20px !important;position: relative;top: 7px;" placeholder="请选择提醒参会人员">
                        <span class="remind_msg">发送事务提示信息</span>
                    </div>
                </li>

                <li class="ulli" style="position: relative"><label class="mui-left" >审批人：</label>
                    <input type="text" placeholder="选择联系人" value="" class="mui-input-clear" id="managerId"/>
                    <input value="" type="hidden"  id="manager" /><span id="Popover_4" class='mui-icon mui-icon-plus'  style="margin-top: 10px"></span>
                </li>

                <li class="ulli">是否是一次性会议：
                    <div class="news_t" style="display: inline-block; width: 60%;">
                        <input type="checkbox" name="roomTimeLimit" num="1" style="    width: 20px !important;position: relative;top: 7px;" checked="checked">
                        <span class="remind_msg">一次性</span>
                    </div>
                </li>
                <textarea name="meetDesc" id="cont"   placeholder="输入日程内容" style="padding: 6px 0 0 6px;width: 90%;height: 45%;margin-left: 5%;margin-top: 10px;"></textarea>
            </ul>

        </div>
    </div>
<%--  会议主持人  --%>
    <div class="mui-content" style="display: none" id="ccc">
        <div class="mui-bar mui-bar-nav" id="header2">
            <a class="mui-icon mui-icon-close mui-pull-left app" href="#modal" id="app"></a>
            <h1 class="mui-title">选择人员</h1>
            <a class="mui-btn-link mui-pull-right" id="re_mail">确认</a>
        </div>
        <div  style="height: 100%;margin-top: 55px;overflow-y: auto;">
            <div id="forms" >

            </div>
        </div>
    </div>
<%--    会议纪要员--%>
    <div class="mui-content"  style="display: none" id="bbb">
        <div class="mui-bar mui-bar-nav" id="header1">
            <a class="mui-icon mui-icon-close mui-pull-left app" href="#modal1"  id="app1"></a>
            <h1 class="mui-title">选择人员</h1>
            <a class="mui-btn-link mui-pull-right" id="re_mail1">确认</a>
        </div>
        <div  style="height: 100%;margin-top: 55px;overflow-y: auto;">
            <div id="forms1">

            </div>
        </div>
    </div>
<%--参会人员--%>
    <div class="mui-content"  style="display: none" id="ddd">
        <div class="mui-bar mui-bar-nav" id="header3">
            <a class="mui-icon mui-icon-close mui-pull-left app" href="#modal1"  id="app3"></a>
            <h1 class="mui-title">选择人员</h1>
            <a class="mui-btn-link mui-pull-right" id="re_mail3">确认</a>
        </div>
        <div  style="height: 100%;margin-top: 55px;overflow-y: auto;">
            <div id="forms3">

            </div>
        </div>
    </div>
    <%--审批人--%>
    <div class="mui-content"  style="display: none" id="eee">
        <div class="mui-bar mui-bar-nav" id="header4">
            <a class="mui-icon mui-icon-close mui-pull-left app" href="#modal1"  id="app4"></a>
            <h1 class="mui-title">选择人员</h1>
            <a class="mui-btn-link mui-pull-right" id="re_mail4">确认</a>
        </div>
        <div  style="height: 100%;margin-top: 55px;overflow-y: auto;">
            <div id="forms4">

            </div>
        </div>
    </div>
    <%--选择部门--%>
    <div class="mui-content"  style="display: none" id="fff">
        <div class="mui-bar mui-bar-nav" id="header5" style="height: 100px;">
            <a class="mui-icon mui-icon-close mui-pull-left" href="#modal1"  id="app5"></a>
            <h1 class="mui-title">选择查看部门</h1>
            <a class="mui-btn-link mui-pull-right" id="re_mail5">确认</a>
            <div style="margin-top: 45px;">
                <span>部门名称</span>
                <input type="text" name="deptName" style="width: 60%;height: 36px;border-radius: 10px">
                <button type="button" class="mui-btn mui-btn-primary deptSeach" style="vertical-align: text-bottom;border-radius: 10px">搜索</button>
            </div>
        </div>
        <div  style="height: 100%;overflow-y: auto;">
            <div id="forms5" style="margin-top: 115px">

            </div>
        </div>
    </div>
</body>
</html>
<script>

    $(function () {

        //选择收件人，抄送人
        var btn0 = document.getElementById("Popover_0");

        btn0.addEventListener('tap', function() {
            // var header = document.getElementById("headerFa")
            var bt111 = document.getElementById("box");
            var bt = document.getElementById("ccc");
            bt111.style.display= "none";
            // header.style.display= "none";
            bt.style.display= "block";
            mui.ajax('/user/getAlluser', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                success: function (data) {
                    //服务器返回响应，根据响应结果，分析是否登录成功；
                    if (data.flag) {
                        var str='';
                        var arr=data.obj
                        for(var i=0;i<arr.length;i++){
                            str+='<div class="mui-input-row mui-checkbox mui-left">'+
                                '<label style="line-height: 0">'+arr[i].userName+'</label>'+
                                '<input style=" width: 20px;height: 20px;border: 1px solid #666; position: absolute; left: 17px;" class="checkbox1" name="checkbox1" value="'+arr[i].userName+'" type="radio" user_id="'+arr[i].userId+'">'+
                                '</div>'
                        }

                    }

                    $("#forms")[0].innerHTML = str;
                },
                error: function (xhr, type, errorThrown) {
                    //异常处理；
                }
            });
            mui("#header2").on('tap', '#re_mail', function () {
                var rdsObj   = document.getElementsByClassName('checkbox1');
                var checkVal = new Array();
                var k        = 0;
                for(i = 0; i < rdsObj.length; i++){
                    if(rdsObj[i].checked){
                        checkVal[k] = rdsObj[i].value;
                        k++;
                    }
                }

                var rdsObj   = document.getElementsByClassName('checkbox1');
                checkVals = new Array();

                var k = 0;
                for(i = 0; i < rdsObj.length; i++){
                    if(rdsObj[i].checked){
                        checkVals[k] = rdsObj[i].getAttribute('user_id');
                        k++;
                    }
                }
                bt111.style.display= "block";
                bt.style.display= "none";
                header.style.display= "block";
                document.getElementById("hostUserId").setAttribute('value',checkVal);
                document.getElementById("hostUserId").setAttribute('user_id',checkVals);
            });
            mui("#header2").on('tap', '#app', function () {
                bt111.style.display= "block";
                bt.style.display= "none";
                header.style.display= "block";
            })
        });

        var btn1 = document.getElementById("Popover_1");
        btn1.addEventListener('tap', function() {
            var bt111 = document.getElementById("box");
            var bt = document.getElementById("bbb");
            bt111.style.display= "none";
            // header.style.display= "none";
            bt.style.display= "block";
            mui.ajax('/user/getAlluser', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                success: function (data) {
                    //服务器返回响应，根据响应结果，分析是否登录成功；
                    if (data.flag) {
                        var str='';
                        var arr=data.obj
                        for(var i=0;i<arr.length;i++){
                            str+='<div class="mui-input-row mui-checkbox mui-left">'+
                                '<label style="line-height: 0">'+arr[i].userName+'</label>'+
                                '<input style=" width: 20px;height: 20px;border: 1px solid #666; position: absolute; left: 17px;" class="checkbox2" name="checkbox2" value="'+arr[i].userName+'" type="radio" user_id="'+arr[i].userId+'">'+
                                '</div>'
                        }

                    }

                    $("#forms1")[0].innerHTML = str;
                },
                error: function (xhr, type, errorThrown) {
                    //异常处理；
                    //console.log(type);
                }
            });
            mui("#header1").on('tap', '#re_mail1', function () {

                var rdsObj   = document.getElementsByClassName('checkbox2');
                var checkVal = new Array();
                var k        = 0;

                for(i = 0; i < rdsObj.length; i++){
                    if(rdsObj[i].checked){
                        checkVal[k] = rdsObj[i].value;
                        k++;
                    }
                }
                var rdsObj   = document.getElementsByClassName('checkbox2');
                checkVals1 = new Array();
                var k = 0;
                for(i = 0; i < rdsObj.length; i++){
                    if(rdsObj[i].checked){
                        checkVals1[k] = rdsObj[i].getAttribute('user_id');
                        k++;
                    }
                }


                bt111.style.display= "block";
                bt.style.display= "none";
                header.style.display= "block";
                console.log(checkVals1)
                document.getElementById("summaryUserId").setAttribute('value',checkVal);
                document.getElementById("summaryUserId").setAttribute('user_id',checkVals1);
            });
            mui("#header1").on('tap', '#app1', function () {
                bt111.style.display= "block";
                bt.style.display= "none";
                header.style.display= "block";
            })
        });

        var btn2 = document.getElementById("Popover_3");
        btn2.addEventListener('tap', function() {
            var bt111 = document.getElementById("box");
            var bt = document.getElementById("ddd");
            bt111.style.display= "none";
            // header.style.display= "none";
            bt.style.display= "block";
            mui.ajax('/user/getAlluser', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                success: function (data) {
                    //服务器返回响应，根据响应结果，分析是否登录成功；
                    if (data.flag) {
                        var str='';
                        var arr=data.obj
                        for(var i=0;i<arr.length;i++){
                            str+='<div class="mui-input-row mui-checkbox mui-left">'+
                                '<label style="line-height: 1px">'+arr[i].userName+'</label>'+
                                '<input style=" width: 70px;height: 70px;" class="checkbox3" name="checkbox3" value="'+arr[i].userName+'" type="checkbox" user_id="'+arr[i].userId+'">'+
                                '</div>'
                        }

                    }

                    $("#forms3")[0].innerHTML = str;
                },
                error: function (xhr, type, errorThrown) {
                    //异常处理；
                    //console.log(type);
                }
            });
            mui("#header3").on('tap', '#re_mail3', function () {

                var rdsObj   = document.getElementsByClassName('checkbox3');
                var checkVal = new Array();
                var k        = 0;
                for(i = 0; i < rdsObj.length; i++){
                    if(rdsObj[i].checked){
                        checkVal[k] = rdsObj[i].value;
                        k++;
                    }
                }
                var rdsObj   = document.getElementsByClassName('checkbox3');
                checkVals1 = new Array();
                var k = 0;
                for(i = 0; i < rdsObj.length; i++){
                    if(rdsObj[i].checked){
                        checkVals1[k] = rdsObj[i].getAttribute('user_id');
                        k++;
                    }
                }


                bt111.style.display= "block";
                bt.style.display= "none";
                // header.style.display= "block";
                document.getElementById("userIds").setAttribute('value',checkVal);
                document.getElementById("userIds").setAttribute('user_id',checkVals1);
            });
            mui("#header3").on('tap', '#app3', function () {
                bt111.style.display= "block";
                bt.style.display= "none";
                header.style.display= "block";
            })
        });

        var btn3 = document.getElementById("Popover_4");
        btn3.addEventListener('tap', function() {
            var bt111 = document.getElementById("box");
            var bt = document.getElementById("eee");
            bt111.style.display= "none";
            // header.style.display= "none";
            bt.style.display= "block";
            mui.ajax('/user/getAlluser', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                success: function (data) {
                    //服务器返回响应，根据响应结果，分析是否登录成功；
                    if (data.flag) {
                        var str='';
                        var arr=data.obj
                        for(var i=0;i<arr.length;i++){
                            str+='<div class="mui-input-row mui-checkbox mui-left">'+
                                '<label style="line-height: 0">'+arr[i].userName+'</label>'+
                                '<input style=" width: 20px;height: 20px;border: 1px solid #666; position: absolute; left: 17px;" class="checkbox4" name="checkbox4" value="'+arr[i].userName+'" type="radio" user_id="'+arr[i].userId+'">'+
                                '</div>'
                        }

                    }

                    $("#forms4")[0].innerHTML = str;
                },
                error: function (xhr, type, errorThrown) {
                    //异常处理；
                    //console.log(type);
                }
            });
            mui("#header4").on('tap', '#re_mail4', function () {

                var rdsObj   = document.getElementsByClassName('checkbox4');
                var checkVal = new Array();
                var k        = 0;
                for(i = 0; i < rdsObj.length; i++){
                    if(rdsObj[i].checked){
                        checkVal[k] = rdsObj[i].value;
                        k++;
                    }
                }
                var rdsObj   = document.getElementsByClassName('checkbox4');
                checkVals1 = new Array();
                var k = 0;
                for(i = 0; i < rdsObj.length; i++){
                    if(rdsObj[i].checked){
                        checkVals1[k] = rdsObj[i].getAttribute('user_id');
                        k++;
                    }
                }


                bt111.style.display= "block";
                bt.style.display= "none";
                // header.style.display= "block";
                document.getElementById("managerId").setAttribute('value',checkVal);
                document.getElementById("managerId").setAttribute('user_id',checkVals1);
            });
            mui("#header4").on('tap', '#app4', function () {
                bt111.style.display= "block";
                bt.style.display= "none";
                header.style.display= "block";
            })
        });

        //部门
        $('#cname,#Popover_5').on('tap', function() {
            document.activeElement.blur();
            var bt111 = document.getElementById("box");
            var bt = document.getElementById("fff");
            bt111.style.display= "none";
            // header.style.display= "none";
            bt.style.display= "block";
            mui.ajax('/department/getAlldept', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                success: function (data) {
                    //服务器返回响应，根据响应结果，分析是否登录成功；
                    if (data.flag) {
                        var str='';
                        var arr=data.obj
                        for(var i=0;i<arr.length;i++){
                            str+='<div class="mui-input-row mui-radio mui-left">'+
                                '<label style="line-height: 1px">'+arr[i].deptName+'</label>'+
                                '<input style="width: 20px;height: 20px;position: absolute;left:20px " class="checkbox5" name="checkbox5" value="'+arr[i].deptName+'" type="checkbox" deptId="'+arr[i].deptId+'">'+
                                '</div>'
                        }
                    }

                    $("#forms5")[0].innerHTML = str;
                }
            });
            $('.deptSeach').on('tap', function() {
                mui.ajax('/department/selByLikeDeptName', {
                    dataType: 'json',//服务器返回json格式数据
                    type: 'get',//HTTP请求类型
                    data:{
                        deptName:$('input[name="deptName"]').val()
                    },
                    success: function (data) {
                        //服务器返回响应，根据响应结果，分析是否登录成功；
                        if (data.flag) {
                            var str='';
                            var arr=data.obj
                            for(var i=0;i<arr.length;i++){
                                str+='<div class="mui-input-row mui-radio mui-left">'+
                                    '<label style="line-height: 34px">'+arr[i].deptName+'</label>'+
                                    '<input style="width: 70px;height: 70px;" class="checkbox5" name="checkbox5" value="'+arr[i].deptName+'" type="radio" deptId="'+arr[i].deptId+'">'+
                                    '</div>'
                            }
                        }

                        $("#forms5")[0].innerHTML = str;
                    }
                });
            })
            mui("#header5").on('tap', '#re_mail5', function () {

                var rdsObj   = document.getElementsByClassName('checkbox5');
                var checkVal = new Array();
                var k        = 0;
                for(i = 0; i < rdsObj.length; i++){
                    if(rdsObj[i].checked){
                        checkVal[k] = rdsObj[i].value;
                        k++;
                    }
                }
                var rdsObj   = document.getElementsByClassName('checkbox5');
                checkVals1 = new Array();
                var k = 0;
                for(i = 0; i < rdsObj.length; i++){
                    if(rdsObj[i].checked){
                        checkVals1[k] = rdsObj[i].getAttribute('deptId');
                        k++;
                    }
                }


                bt111.style.display= "block";
                bt.style.display= "none";
                // header.style.display= "block";
                document.getElementById("deptId").setAttribute('value',checkVal);
                document.getElementById("deptId").setAttribute('deptId',checkVals1);
            });
            mui("#header5").on('tap', '#app5', function () {
                bt111.style.display= "block";
                bt.style.display= "none";
                header.style.display= "block";
            })
        });
        $('#app5').click(function(){
            var bt111 = document.getElementById("box");
            var bt = document.getElementById("fff");
            bt111.style.display= "block";
            // header.style.display= "block";
            bt.style.display= "none";

        })

    });
    //保存
    $('.saveBtn').click(function () {
        if($('#maxUser').val() == ''){
            layer.msg("请输入最大用户数");
            return false
        }else if ($('[name="meetName"]').val() == '') {
            layer.msg("请输入会议名称");
            return false
        }else if ($('[name="startTime"]').val()  == '' || $('[name="endTime"]').val() == '') {
            layer.msg("请输入会议时间");
            return false
        }else if($('input[name="roomPwd"]').val()== ''){
            layer.msg("请输入会议密码");
            return false
        }else if($('#managerId').val() == '') {
            layer.msg("请输入会议审批人");
            return false
        }

        //事务提醒
        var isAttend = 0
        if ( $('input:checkbox[name="isAttend"]:checked').attr('num') == 1) {
            isAttend = 1;
        }
        //是否是一次性会议
        var roomTimeLimit = 0
        if ( $('input:checkbox[name="roomTimeLimit"]:checked').attr('num') == 1) {
            roomTimeLimit = 1;
        }

        var meetingId='';
        var roomId=0

        //主持人
        var hostUserId = ''
        if($('#hostUserId').attr('user_id') != undefined){
            var hostUserId1 = $('#hostUserId').attr('user_id').split(",")
            var hostUserId = ''
            for(var i=0;i<hostUserId1.length;i++){
                hostUserId += hostUserId1[i]
            }
        };
        //会议纪要员
        var summaryUserId = ''
        if($('#summaryUserId').attr('user_id') != undefined){
            var summaryUserId1 =  $('#summaryUserId').attr('user_id').split(",")
            var summaryUserId = ''
            for(var i=0;i<summaryUserId1.length;i++){
                summaryUserId += summaryUserId1[i]
            }
        };

        //参会人员
        var userIds = ''
        if($('#userIds').attr('user_id') != undefined){

            var userIds1=$('#userIds').attr('user_id').split(",")
            // return false
            for(var i=0;i<userIds1.length;i++){
                userIds +=userIds1[i]
            }
        };

        //查看部门
        var deptId = ''
        if($('#deptId').attr('deptid') != undefined){
            deptId = $('#deptId').attr('deptid')+','

        };


        //审批人
        var managerId = ''
        if($('#managerId').attr('user_id') != undefined){
            var managerId1 = $('#managerId').attr('user_id').split(",")
            for(var i=0;i<managerId1.length;i++){
                managerId+= managerId1[i]
            }
        };


        // return false
        var data = {
            meetingId:'',
            roomPwd:$('[name="roomPwd"]').val(),
            hostUserId:hostUserId,
            userIds:userIds,
            summaryUserId: summaryUserId,
            deptId: deptId,
            meetName: $('[name="meetName"]').val(),
            managerId: managerId,
            maxUser: $('.maxUser').val(),
            roomId: 0,
            meetDesc: $('#cont').val(),
            meetAddress: $('.meetAddress').val(),
            startTime: $('[name="startTime"]').val(),
            endTime: $('[name="endTime"]').val(),
            isAttend: isAttend,
            attachmentId: '',
            attachmentName: '',
            roomTimeLimit: roomTimeLimit,
            isop:'1'
        }


        $.ajax({
            url: '/JHTMeeting/insertJHTMeeting',
            type: 'post',
            dataType: 'json',
            data: data,
            success: function (data) {
                if (data.flag) {
                    layer.msg('保存成功！', {icon: 1}, function () {
                        $('.main').show();
                        $('.mainAdd').hide();
                        window.location.reload()
                        history.back(-1)
                    });
                    /*添加成功*/
                } else {
                    layer.msg('保存失败！', {icon: 2});
                    /*添加失败*/
                }
            },
            error: function (data) {
                layer.msg('保存失败！', {icon: 2});
                /*添加失败*/
            }
        })
    })
</script>
